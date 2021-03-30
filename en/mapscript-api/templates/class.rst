{{ fullname | escape | underline}}

.. currentmodule:: {{ module }}

.. autoclass:: {{ objname }}

   .. include:: ../includes/{{ objname }}.rst

   {% block attributes %}
   {% if attributes %}
   .. rubric:: {{ _('Attributes') }}

Hello63

   .. autosummary::
   {% for item in attributes %}
      ~{{ name }}.{{ item }}
   {%- endfor %}
   {% endif %}
   {% endblock %}
   
   {% block methods %}
   
   {% if methods %}
   .. rubric:: {{ _('Methods') }}
   
   {% for item in methods %}
   .. automethod:: {{ name }}.{{ item }}
   {%- endfor %}
   {% endif %}
   {% endblock %}


