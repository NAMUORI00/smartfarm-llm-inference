#!/usr/bin/env bash
set -euo pipefail

LOG_DIR=${LOG_DIR:-"."}
PID_FILE=${PID_FILE:-"${LOG_DIR}/llama-local.pid"}
LOG_FILE=${LOG_FILE:-"${LOG_DIR}/llama-local.log"}
PORT=${PORT:-45857}

cmd=${1:-}
mkdir -p "$LOG_DIR"

case "$cmd" in
  start)
    shift
    exec ./scripts/llm/run-llama-local.sh "$@"
    ;;
  stop)
    if [ -f "$PID_FILE" ]; then
      pid=$(cat "$PID_FILE")
      if kill -0 "$pid" 2>/dev/null; then
        kill "$pid"
        echo "stopped pid $pid"
      fi
      rm -f "$PID_FILE"
    else
      echo "no pid file: $PID_FILE"
    fi
    ;;
  restart)
    "$0" stop || true
    shift || true
    exec "$0" start "$@"
    ;;
  health)
    curl -sS "http://localhost:${PORT}/health" || true
    ;;
  logs)
    tail -n "${2:-200}" -F "$LOG_FILE"
    ;;
  *)
    echo "usage: $0 {start|stop|restart|health|logs} [args...]" >&2
    exit 2
    ;;
esac
