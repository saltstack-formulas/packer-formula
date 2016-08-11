# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "packer/map.jinja" import packer with context %}
{% set extract_path = packer.path.extract_to|replace('VERSION', packer.download.version) %}
# 
# Fetch the file from packer
#
packer-extract-binary:
  archive.extracted:
    - name: {{ extract_path }}
    - source: {{ packer.download.url|replace('VERSION', packer.download.version) }}
    - source_hash: {{ packer.download.hash }}
    - archive_format: zip
  # make packer executable
  cmd.run:
    - name: |
        chmod +x {{ extract_path }}/packer
    - runas: root
    - shell: /bin/bash
    - require:
        - archive: packer-extract-binary
