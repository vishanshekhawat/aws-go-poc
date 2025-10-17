# Copilot instructions — aws-go-poc

This repository is a tiny Go HTTP service Proof-of-Concept (ECS PoC). The goal of these notes is to give an AI coding agent immediate, actionable context so changes are correct and low-risk.

Key facts

- Single service: `app/main.go` — a minimal HTTP server (listens on port 8080, uses `http.HandleFunc` and `fmt.Fprintf`).
- Module: `github.com/vishanshekhawat/aws-go-poc` (see `app/go.mod`). Go version: 1.24.x.
- Docker: multi-stage `app/Dockerfile` is present and intended for containerizing the service for AWS ECS.

How to run and build (explicit)

- Run locally (fast):
  - cd into the app and run: `cd app && go run .` (or `go run main.go` from `app/`).
  - Build a local binary: `cd app && go build -o myapp .` then `./myapp`.
- Build Docker image (from repository root):
  - `docker build -f app/Dockerfile -t aws-go-poc .`

Dockerfile gotcha (important for edits)

- Current `app/Dockerfile` uses a multi-stage build but attempts `go build -o myapp ./cmd/server`. In this repo the main program is at `app/main.go` (not `./cmd/server`). If you change source layout or modify the Dockerfile, either:
  - Update the Dockerfile to build the correct package: `RUN go build -o myapp .`
  - Or move sources to `cmd/server` if you intend that layout.
- When suggesting Dockerfile edits, prefer the minimal change above and keep the multi-stage approach (builder + small runtime image).

Project-specific conventions & patterns

- Very small PoC style: handler registration is done directly in `main.go` using `http.HandleFunc`. Follow that pattern for adding endpoints rather than introducing new frameworks.
- Error handling is minimal (e.g., `http.ListenAndServe` is called without checking the returned error). If you add production changes, document them clearly in PRs.
- No tests or CI currently. If adding tests, place them next to implementation files as `*_test.go` and run `go test ./...`.

Integration points

- There are no imported AWS SDKs or external services in the current code. The repository appears intended for ECS deployment (see Dockerfile and the `Hello from Go ECS PoC!` message in `main.go`).

Editing guidance for Copilot-style suggestions

- Keep changes scoped: this repo is a simple PoC. Avoid large refactors unless the PR includes:
  - clear motive (e.g., add AWS integration),
  - a test or smoke-run instructions, and
  - Dockerfile and README updates.
- When adding endpoints, mirror the existing style in `main.go`: simple handlers and global registration.
- When modifying container setup, prefer the single-line Dockerfile fix above rather than reworking the whole image stack.

Files to reference when making changes

- `app/main.go` — service implementation and handler examples.
- `app/go.mod` — module path and Go version.
- `app/Dockerfile` — multi-stage container build; review the `go build` line for path correctness.

If something is ambiguous

- Run the service locally (`cd app && go run .`) and confirm behavior.
- If the Dockerfile build fails, check the `go build` package path; suggest the minimal fix documented above.

Edit checklist (quick when opening a PR)

- Confirm `cd app && go run .` still works.
- If Docker changes: `docker build -f app/Dockerfile -t aws-go-poc .` succeeds.
- Add/adjust tests or a short README entry if you change the service surface or container behavior.

If you'd like, I can also open a PR that fixes the Dockerfile `go build` path to match the current layout.
