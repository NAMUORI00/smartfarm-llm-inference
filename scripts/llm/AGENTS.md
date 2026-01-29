<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-01-27 | Updated: 2026-01-27 -->

# llm/

LLM server management and utility scripts for running local llama.cpp inference.

## KEY FILES

| File | Description |
|------|-------------|
| `run-llama-local.sh` | Start local llama.cpp server with GGUF models |
| `llama-local-manage.sh` | Manage llama.cpp process (start/stop/restart) |

## PURPOSES

- **Local Inference**: Run quantized GGUF models via llama.cpp
- **Server Lifecycle**: Start, stop, monitor llama.cpp server
- **Port Management**: Default port `45857` (aligns with `LLMLITE_HOST` default)

## CONFIGURATION

Environment variables:

```bash
# Model configuration
MODEL_PATH="/path/to/model.gguf"   # GGUF file path

# Server settings
PORT=45857                         # llama.cpp server port
LOG_DIR="."                        # pid/log directory
SERVER_BIN="./llama.cpp/build/bin/llama-server"  # optional override
```

## USAGE

```bash
# Start llama.cpp server
bash scripts/llm/run-llama-local.sh

# Manage process (requires llama-local-manage.sh)
bash scripts/llm/llama-local-manage.sh start
bash scripts/llm/llama-local-manage.sh stop
bash scripts/llm/llama-local-manage.sh health
bash scripts/llm/llama-local-manage.sh logs 200
```

## CONVENTIONS

- Scripts use `#!/bin/bash` shebang with `-euo pipefail`
- Configuration via environment variables
- PID files for process tracking
- Logs to stdout (no log file rotation)

## FOR AI AGENTS

When modifying LLM scripts:
- Test with multiple GGUF quantizations (Q4_K_M, Q5_K_M)
- Ensure Jetson compatibility (limit GPU layers for 8GB RAM)
- Verify `PORT` is available before launch (default `45857`)
- Keep `LLMLITE_HOST` (FastAPI) and `PORT` (llama-server) aligned
