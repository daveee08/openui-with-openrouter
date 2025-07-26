# Procfile for platforms like Heroku, Render, etc.
# This tells the platform how to start your web application

web: cd backend && python -m uvicorn open_webui.main:app --host 0.0.0.0 --port $PORT --workers 1
release: cd backend && python -m alembic upgrade head
