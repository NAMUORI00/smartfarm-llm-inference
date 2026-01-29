# smartfarm-llm-inference

Standalone llama.cpp inference service (GGUF) for SmartFarm.

## Quick start

```bash
docker compose up -d
curl -sS http://localhost:45857/health
```

## Notes

- Put GGUF model files under `models/` (default: `models/Qwen3-4B-Q4_K_M.gguf`).
- Override with `LLAMA_MODEL_PATH=/models/<file>.gguf` and `LLAMA_HOST_PORT=45857`.
