# SmartFarm LLM Inference

llama.cpp OpenAI-compatible 서버 구성입니다.

## Quick Start
```bash
cd smartfarm-llm-inference
docker compose up -d
curl -sS http://localhost:45857/health
```

## Model
- 기본 경로: `models/Qwen3-4B-Q4_K_M.gguf`
- 오버라이드: `LLAMA_MODEL_PATH=/models/<file>.gguf`

## Scripts
- `scripts/llm/run-llama-local.sh`: 로컬 llama-server 실행
- `scripts/llm/llama-local-manage.sh`: start/stop/status 관리
