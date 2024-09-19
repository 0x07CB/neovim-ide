---
layout: default
---

{% if page.lang == 'fr' %}
{% include_relative _i18n/fr/home.md %}
<div class="language-switcher">
  <a href="{{ site.baseurl }}/en">English</a>
  Français
</div>
{% else %}
{% include_relative _i18n/en/home.md %}
<div class="language-switcher">
  English
  <a href="{{ site.baseurl }}/fr">Français</a>
</div>
{% endif %}