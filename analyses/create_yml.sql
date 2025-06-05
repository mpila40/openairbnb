{% set models_to_generate = codegen.get_models(directory='opendata', prefix='stg_') %}
{{ codegen.generate_model_yaml(
    model_names = models_to_generate
) }}