class AirflowMixin:
    def __init__(self, *args, **kwargs):
        pass

    def __call__(self, *args, **kwargs):
        self.run(*args, **kwargs)
