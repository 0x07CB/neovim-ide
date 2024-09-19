---
layout: default
---

{% if page.lang == 'fr' %}
{% include_relative _i18n/fr/home.md %}
{% else %}
{% include_relative _i18n/en/home.md %}
{% endif %}

<div class="language-switcher">
  {% if page.lang == 'fr' %}
    <a href="{{ site.baseurl }}/">English</a>
    Français
  {% else %}
    English
    <a href="{{ site.baseurl }}/fr">Français</a>
  {% endif %}
</div>