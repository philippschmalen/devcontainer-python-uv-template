import logging
import logging.config
import os

import dotenv

dotenv.load_dotenv()


LOGGING_CONFIG = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {
        "simple": {
            "format": "%(asctime)s [%(levelname)s] %(name)s: %(message)s",
            "datefmt": "%Y-%m-%d %H:%M:%S",
        }
    },
    "handlers": {
        "stdout": {
            "class": "logging.StreamHandler",
            "level": "INFO",
            "formatter": "simple",
            "stream": "ext://sys.stdout",  # Default is stderr
        },
        "file": {
            "class": "logging.handlers.RotatingFileHandler",
            "level": "INFO",
            "formatter": "simple",
            "filename": "output.log",
            "maxBytes": 10485760,  # 10MB
            "backupCount": 5,
        },
    },
    "loggers": {
        "": {"handlers": ["stdout", "file"], "level": "DEBUG", "propagate": False},
        "__main__": {
            "handlers": ["stdout", "file"],
            "level": "INFO",
            "propagate": False,
        },
    },
}


def setup_logging(logger_name: str) -> logging.Logger:
    "Configures a logger with a name. Use __name__ for the module's name."
    logging.config.dictConfig(LOGGING_CONFIG)
    logger = logging.getLogger(logger_name)
    logger.setLevel(
        logging.DEBUG if os.getenv("DEVELOPMENT") == "True" else logging.INFO
    )
    return logger
