set dotenv-load

# list all tasks
default:
  @just --list

# setup development environment
setup-dev:
    curl -LsSf https://astral.sh/uv/install.sh | sh
    uv pip install pre-commit
    pre-commit install --install-hooks --hook-type commit-msg

# test
test: 
    uv run pytest --cov=src -s

# format
format:
    uv run ruff format
    uv run docformatter --in-place --config ./pyproject.toml src tests

# check before commit
check: 
    pre-commit run -a

# clean
clean:
    uv cache clean

# inspector
inspector:
    npx @modelcontextprotocol/inspector -e PYTHONPATH=src -e CORPORATE_ID=$CORPORATE_ID -e USER_EMAIL=$USER_EMAIL -e USER_PASSWORD=$USER_PASSWORD uv --directory . run toyoko_mcp_cli