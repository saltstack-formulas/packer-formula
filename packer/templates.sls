# -*- coding: utf-8 -*-
# vim: ft=sls

{%- from "packer/map.jinja" import packer with context %}

packer_templates_create_directory:
  file.directory:
    - name: {{ packer.path.templates }}
    - makedirs: True

{%- for repo_name, repo in salt['pillar.get']('packer:lookup:templates', {}).items() %}

{%- if repo == None %}
{%- set repo = {} %}
{%- endif %}

{%- set address = repo.get('address') %}
{%- set revision = repo.get('revision', 'master') %}

packer_templates_git_repo_{{ repo_name }}:
  git.latest:
    - name: {{ address }}
    - target: {{ packer.path.templates }}/{{ repo_name }}
    - rev: {{ revision }}
    - require:
      - file: packer_templates_create_directory

{%- endfor %}
