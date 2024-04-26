import dotenv

from conf.logging_config import setup_logging

dotenv.load_dotenv(override=True, verbose=True)
config = dotenv.dotenv_values(verbose=True)
logger = setup_logging(__name__)

if __name__ == "__main__":
    logger.info("Hello from main.py!")
    logger.info(f"Loaded config: {config}")
