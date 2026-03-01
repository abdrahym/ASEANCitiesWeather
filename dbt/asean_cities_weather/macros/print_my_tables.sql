{% macro print_source_yaml_ddb(schema_name) %}

    {# 1. Query langsung ke information_schema tanpa pusing nama database #}
    {% set query %}
        select table_name
        from information_schema.tables
        where table_schema = '{{ schema_name }}'
        order by table_name
    {% endset %}

    {% set results = run_query(query) %}

    {# 2. Cetak hasilnya dalam format YAML #}
    {% if execute %}
        {{ log('\n--- COPY DARI SINI ---', info=True) }}
        {{ log('version: 2', info=True) }}
        {{ log('sources:', info=True) }}
        {{ log('  - name: ' ~ schema_name, info=True) }}
        {{ log('    schema: ' ~ schema_name, info=True) }}
        {{ log('    tables:', info=True) }}

        {% for row in results.rows %}
        {{ log('      - name: ' ~ row[0], info=True) }}
        {% endfor %}
        {{ log('--- SAMPAI SINI ---\n', info=True) }}
    {% endif %}

{% endmacro %}