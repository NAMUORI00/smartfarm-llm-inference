#!/usr/bin/env bash
set -euo pipefail

# Default to a local GGUF if present (offline-friendly)
if [ -z "${MODEL_PATH:-}" ]; then
  for cand in \
    "./models/Qwen3-4B-Instruct-2507-Q4_K_M.gguf" \
    "./models/Qwen3-4B-Q4_K_M.gguf" \
    "./models/qwen2.5-1.5b-instruct-q4_k_m.gguf"
  do
    if [ -f "$cand" ]; then
      MODEL_PATH="$cand"
      break
    fi
  done
fi

MODEL_PATH=${MODEL_PATH:-"./models/Qwen3-4B-Q4_K_M.gguf"}
PORT=${PORT:-45857}
HOST=0.0.0.0
LOG_DIR=${LOG_DIR:-"."}
PID_FILE=${PID_FILE:-"${LOG_DIR}/llama-local.pid"}
LOG_FILE=${LOG_FILE:-"${LOG_DIR}/llama-local.log"}

mkdir -p "$LOG_DIR"

# Prefer local build from llama.cpp if present
SERVER_BIN=${SERVER_BIN:-"./llama.cpp/build/bin/llama-server"}
if [ ! -x "$SERVER_BIN" ] && command -v llama-server >/dev/null 2>&1; then
  SERVER_BIN=$(command -v llama-server)
fi

if [ ! -x "$SERVER_BIN" ]; then
  echo "llama-server binary not found. Build llama.cpp or install llama-server into PATH." >&2
  exit 1
fi

if [ ! -f "$MODEL_PATH" ]; then
  echo "Model file not found: $MODEL_PATH" >&2
  echo "Place the GGUF under ./models or export MODEL_PATH to the file." >&2
  exit 1
fi

echo "Starting llama-server on $HOST:$PORT with model $MODEL_PATH ..."
nohup "$SERVER_BIN" \
  --model "$MODEL_PATH" \
  --host "$HOST" \
  --port "$PORT" \
  --parallel 4 \
  --ctx-size 4096 \
  > "$LOG_FILE" 2>&1 & echo $! > "$PID_FILE"

echo "llama-server pid: $(cat "$PID_FILE")"
echo "logs: $LOG_FILE"
