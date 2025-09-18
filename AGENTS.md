# AGENTS.md

Concise, high-signal guidance for AI coding agents. Keep this file lean to avoid the "lost in the middle" effect. If something isn't essential for automation or correctness, put it in `README.md` or `docs/` instead.

## 1. TLDR Rules (Most Important First)
Simplicity first. Clarity > cleverness. YAGNI. Single responsibility. Composition over inheritance. Fail fast & loud. Immutable by default. Be explicit, not magic. Descriptive names (why + what). Typed & pythonic. Small focused functions.

Prioritize: clarity, type safety, consistency, tested behavior.

## 2. Core Commands (Copy/Paste Ready)
Build / sync: `uv sync`  (lockfile committed)
Add dependency: `uv add <pkg>`  | Dev only: `uv add --dev <pkg>`
Lint & format: `ruff check --fix && ruff format`
Types: `mypy src/`
Tests (all): `python -m pytest`
Single test: `python -m pytest tests/test_main.py::test_function_name -v`
Coverage: `python -m pytest --cov=src`
Pre-commit (all): `pre-commit run --all-files`
All-in-one local sanity (runs format, lint, type hooks as configured): `pre-commit run --all-files` before ending a turn.

## 3. Project Layout (Minimal Mental Model)
`src/main.py` entrypoint
`src/config/logging_config.py` structured logging
`src/db/db_setup.py` (DB setup logic)
`tests/` mirrors `src/`
`pyproject.toml` deps & tooling config
`.env.sample` template env vars (never commit secrets)

## 4. Testing Expectations
- Name tests: `test_<function>_<scenario>`
- Add/adjust tests for every behavior change
- Mock external IO (DB, network, filesystem)
- Keep tests fast & deterministic
- Don't skip failing tests—fix or delete obsolete code

## 5. Code Style & Design
- Prefer pure, side-effect–minimal functions
- Narrow function signatures; explicit types everywhere (`mypy --strict` friendly)
- Avoid implicit global state; use dependency injection over singletons
- Prefer composition; avoid inheritance unless required by protocol/interface
- Keep modules cohesive; delete dead code quickly
- Return early; no deeply nested pyramids

## 6. Error Handling
```python
# Specific > generic; no bare except
def parse_payload(raw: str) -> dict:
    if not isinstance(raw, str):
        raise TypeError("raw must be str")
    try:
        return json.loads(raw)
    except json.JSONDecodeError as e:
        raise ValueError("Invalid JSON payload") from e
```
Use context managers for resources. Fail fast on invalid inputs.

## 7. Logging
Use the configured structured logger (`logging_config.py`). Log events, not narration. Avoid logging secrets or large blobs.

## 8. Dependency Discipline
Keep dependencies minimal. Justify new ones (security, size, maintenance). Prefer stdlib first. Remove unused packages promptly.

## 9. Security & Config
- Never commit secrets—use environment variables
- Validate external inputs early
- Avoid dynamic `exec` / `eval`
- Keep `.env.sample` in sync with actual required env fields (never commit secrets)

## 10. Things Deliberately Omitted Here
Extended architecture rationale, deployment notes, dataset docs—place in `docs/`. This file stays small (< ~250 lines) for maximal agent relevance.

## 11. Quick Reference Table (Signal-Only)
| Task | Command |
| ---- | ------- |
| Sync deps | `uv sync` |
| Add dep | `uv add <pkg>` |
| Lint & format | `ruff check --fix && ruff format` |
| Types | `mypy src/` |
| Tests | `python -m pytest` |
| One test | `python -m pytest tests/test_main.py::test_name -v` |
| Coverage | `python -m pytest --cov=src` |
| All hooks | `pre-commit run --all-files` |

## 12. Heuristics for Agents
If conflicting instructions: explicit user prompt > this file. Optimize for correctness first, speed second. If a task would sprawl, propose a scoped subset. Always run `pre-commit run --all-files` (ensures lint, format, type hooks) before finalizing changes.

---
Treat this as living documentation. Keep it short. Remove anything stale immediately.
