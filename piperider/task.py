from logging import getLogger
from typing import Dict
from typing import Optional

from piperider.artifacts.base import BaseArtifact
from piperider.exceptions import EmptyOutput
from piperider.exceptions import TaskNotReady
from piperider.mixins import AirflowMixin

logger = getLogger(__name__)


class Task:
    def requirements(self) -> Dict[str, BaseArtifact]:
        return {}

    def output(self) -> Optional[BaseArtifact]:
        return None

    def is_ready(self) -> bool:
        for dep in self.requirements().values():
            if not dep.is_exists():
                return False
        return True

    def is_completed(self) -> bool:
        o = self.output()
        return o is None or o.is_exists()

    def run(self, *args, **kwargs):
        if self.is_completed():
            return
        if not self.is_ready():
            raise TaskNotReady()
        self.procedure(*args, **kwargs)
        if not self.is_completed():
            raise EmptyOutput()

    def procedure(self, *args, **kwargs):
        raise NotImplementedError()


class AirflowTask(AirflowMixin, Task):
    pass
