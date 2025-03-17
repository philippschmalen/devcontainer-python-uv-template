"""
Example for a main.py to setup a logger and load configuration from a .env file.
Could be used as an entrypoint.

1. Loads environment variables from the .env file using `dotenv.load_dotenv()`.
2. Retrieves the loaded configuration using `dotenv.dotenv_values()`.
3. Sets up a logger using `setup_logging()`.
4. Logs a message to indicate that the module has been executed.

Note: Make sure to have PYTHONPATH at project root. Otherwise imports will not work.
"""

import dotenv

from conf.logging_config import setup_logging

dotenv.load_dotenv(override=True, verbose=True)
config = dotenv.dotenv_values(verbose=True)
logger = setup_logging(__name__)

if __name__ == "__main__":
    logger.info("Hello from main.py!")
    logger.info(f"Loaded config: {config}")
