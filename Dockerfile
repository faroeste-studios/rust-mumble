FROM rust:1.81-slim AS builder

WORKDIR /app
COPY . .

# Compila o binário em release
RUN cargo build --release

# --- runtime ---
FROM debian:bookworm-slim

WORKDIR /app
COPY --from=builder /app/target/release/rust-mumble /app/target/release/

EXPOSE 30120
CMD ["./rust-mumble", "--listen", "0.0.0.0:30120"]
