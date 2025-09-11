#import "../../../my-slides.typ": *

#set text(lang: "fr")

#show: doc => my-slides(
  doc,
  presentation_title: "Python & API",
  presentation_subtitle: "Université Toulouse Paul Sabatier - KEAT9AA1",
  date: "2025-09-11",
)

#about-this-presentation

#section-slide("Pre-requisite")

#laas-slide(title: "constructors & str")[
  ```python
  class Point:
      def __init__(self, x: int, y: int):
          self.x = x
          self.y = y

      def __str__(self):
          return f"{self.x} {self.y}"


  if __name__ == "__main__":
      p = Point(3, 4)
      print(p)
  ```
]

#laas-slide(title: "uv")[
  #link("https://docs.astral.sh/uv/")[`https://docs.astral.sh/uv/`]
  ```
  $ uv --version
  ```
  ```
  $ pipx install uv
  $ pip install uv
  $ curl -LsSf https://astral.sh/uv/install.sh | sh
  ```
]

#laas-slide(title: "Django", alignment: horizon + center)[
  #image("../../../media/django.png")

  #link("https://www.djangoproject.com/")[`https://www.djangoproject.com/`]
]

#laas-slide(title: "Django: Quickstart")[
  ```
  $ uv init mysite
  $ cd mysite
  $ uv add django
  $ uv run django-admin startproject mysite .
  $ uv run ./manage.py runserver
  $ uv run ./manage.py migrate
  $ uv run ./manage.py startapp election
  ```
]
#laas-slide(title: "uv shortcut")[
  - edit `manage.py`:
  ```diff
  -#!/usr/bin/env python
  +#!/usr/bin/env -S uv run
  ```
]

#section-slide("Models")

#laas-slide(title: "ORM")[
  #set text(size: 20pt)
  ```python
  # election/models.py
  from django.db import models


  class Election(models.Model):
      title = models.CharField(max_length=200)
      pub_date = models.DateTimeField()


  class Candidate(models.Model):
      election = models.ForeignKey(
          Election,
          on_delete=models.CASCADE,
      )
      name = models.CharField(max_length=200)
      votes = models.IntegerField(default=0)
  ```
]

#laas-slide(title: "Prepare your database")[
  - add `election` in `INSTALLED_APPS` in `mysite/settings.py`

  ```
  $ ./manage.py makemigrations election
  $ ./manage.py migrate
  $ ./manage.py shell
  ```
]

#laas-slide(title: "Interact with your database")[
  ```python
  In [1]: from election.models import *
  In [2]: from django.utils.timezone import now
  In [3]: e = Election.objects.create(
      title="Qui est le meilleur chat ?",
      pub_date=now())
  In [4]: Candidate.objects.create(
      election=e, name="Doc")
  Out[4]: <Candidate: Candidate object (1)>
  In [5]: Candidate.objects.create(
      election=e, Candidate="Mallow")
  Out[5]: <Candidate: Candidate object (2)>
  ```
]

#laas-slide(title: "Define better names")[
  ```python
  # election/models.py
  class Election(models.Model):
      ...
      def __str__(self):
          return self.title


  class Candidate(models.Model):
      ...
      def __str__(self):
          return self.name
  ```
]

#laas-slide(title: "Generate an admin UI")[
  ```python
  # election/admin.py
  from django.contrib import admin

  from . import models

  admin.site.register(models.Election)
  admin.site.register(models.Candidate)
  ```

  ```
  $ ./manage.py createsuperuser
  $ ./manage.py runserver
  ```
]

#section-slide("Views")

#laas-slide(title: "Election List & Detail View")[
  ```python
  # election/views.py
  from django.views.generic import DetailView, ListView
  from .models import Election


  class ElectionListView(ListView):
      model = Election

  class ElectionDetailView(DetailView):
      model = Election
  ```

]
#laas-slide(title: "Route some URLS to your views")[
  ```python
  # mysite/urls.py urlpatterns = [ …

      path(
          "",
          election.views.ElectionListView.as_view(),
          name="elections",
      ),
      path(
          "election/<int:pk>",
          election.views.ElectionDetailView.as_view(),
          name="election",
      ),
  ```
]

#laas-slide(title: "Candidate Detail View")[
  ```python
  # election/views.py
  class CandidateDetailView(DetailView):
      model = Candidate
  ```

  ```python
  # election/urls.py
  urlpatterns = [
      ...
      path(
          "candidate/<int:pk>",
          election.views.CandidateDetailView.as_view(),
          name="candidate",
      ),
  ]
  ```
]

#laas-slide(title: "Let user vote")[
  ```python
  # election/views.py
  from django.views.generic import RedirectView
  from django.views.generic.detail import SingleObjectMixin

  class VoteView(SingleObjectMixin, RedirectView):
      model = Candidate

      def get_redirect_url(self, *args, **kwargs):
          candidate = self.get_object()
          candidate.votes += 1
          candidate.save()
          return f"/candidate/{candidate.id}"
  ```
]
