from typing import Generator

import boto3

from piperider.artifacts.base import BaseArtifact


class S3PrefixArtifact(BaseArtifact):
    def __init__(self, bucket: str, prefix: str):
        # TODO credentials
        self.client = boto3.client("s3")
        self.bucket = bucket
        self.prefix = prefix

    def is_exists(self) -> bool:
        for _ in self.list():
            return True
        return False

    def list(self, max_keys: int = 1000) -> Generator[str, None, None]:
        params = {
            "Bucket": self.bucket,
            "Prefix": self.prefix,
            "MaxKeys": max_keys,
        }
        while params:
            res = self.client.list_objects_v2(**params)
            for content in res.get("Contents", []):
                key = content.get("Key", "/")
                if not key.endswith("/"):
                    yield key
            next_token = res.get("NextContinuationToken")
            if next_token:
                params["NextContinuationToken"] = next_token
            else:
                params = {}
