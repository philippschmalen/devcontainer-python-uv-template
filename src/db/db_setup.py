from src.config.logging_config import setup_logging

logger = setup_logging(__name__)


def dummy_function():
    logger.info("Hello from dummy_function!")
    # print logger config
    logger.info(logger.__dict__)
