# Stage 1: Build the Go binary
FROM golang:1.24-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Go module files and source code
COPY go.mod ./

# Download dependencies
RUN go mod download

# Copy the rest of the source code
COPY . .

# Build the Go application
RUN go build -o myapp .

# Stage 2: Create a smaller image for the final executable
FROM alpine:latest
WORKDIR /root/
# Copy the binary from the builder stage
COPY --from=builder /app/myapp /usr/local/bin/myapp

# Run the Go application
ENTRYPOINT ["myapp"]