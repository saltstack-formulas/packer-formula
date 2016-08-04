{% from "packer/map.jinja" import packer with context -%}
# Ensure that packer is added to the environment
packer-env-file:
  file.managed:
    - name: {{ packer.path.profile }}
    - contents: "export PATH=$PATH:{{ packer.path.profile|replace('VERSION', packer.download.version) }}"
