from piperider import Task
from piperider.artifacts.aws.s3 import S3PrefixArtifact


class PutObj(Task):
    def output(self):
        return S3PrefixArtifact(
            bucket="example-bucket",
            prefix="example_prefix",
        )

    def procedure(self, *args, **kwargs):
        # TODO
        pass
