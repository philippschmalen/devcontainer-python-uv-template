"""
Tests for the endpoints in main.py using FastAPI's TestClient.
"""

from fastapi.testclient import TestClient

from src.main import app

client = TestClient(app)


def test_hello_endpoint_default():
    """Test the hello endpoint with defaults"""
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == "Hello, World!"


def test_hello_endpoint_custom_name():
    """Test the hello endpoint with a custom name"""
    response = client.get("/?name=FastAPI")
    assert response.status_code == 200
    assert response.json() == "Hello, FastAPI!"
