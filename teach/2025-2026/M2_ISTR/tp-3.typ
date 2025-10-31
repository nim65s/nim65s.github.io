#import "../../../my-slides.typ": *

#set text(lang: "fr")

#show: doc => my-slides(
  doc,
  presentation_title: "TP 3",
  presentation_subtitle: "Université Toulouse Paul Sabatier - KEAT9AA1",
  date: "2025-09-26",
)

#laas-slide(title: "JSON")[
  - Implémentez une méthode "`def json(self):`" pour sérialiser chaque modèle dans `high_level/models.py`
  - Implémentez des `DetailView` pour vos classes qui appellement ces `.json()` dans `high_level/views.py`.
    Pour cela, utilisez `django.http.JsonResponse` dans la méthode `render_to_response`
  - Ajoutez des routes pour ces vues dans `boisson/urls.py`
  - Testez les avec `curl`: toutes les informations sur un modèle en particulier doivent apparaître

  ref. #link("https://ccbv.co.uk/DetailView")
]

#laas-slide(title: "JSON étendu")[
  - Implémentez une méthode "`def json_extended(self):`" pour sérialiser chaque modèle et ses relations
  - Ajoutez une vue `ApiView` dans `high_level/views.py`
  - Ajoutez une route `/api/<int:pk>` dans `boisson/urls.py`
  - Testez la avec `curl`: toutes les informations nécessaires au code C++ doivent apparaître
]
