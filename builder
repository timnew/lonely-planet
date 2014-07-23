#!/usr/bin/env ruby

require './lib/all'

require 'commander/import'

program :version, '0.0.1'
program :description, 'Lonely Planet Render'

command :render do |c|
  c.syntax = 'render render [options]'
  c.description = 'Render html files from dataset'

  c.option '-t', '--taxonomy FILE', 'Specify the path to taxonomy xml file (default: taxonomy.xml)'
  c.option '-d', '--destinations FILE', 'Specify the path to destination xml file(default: destinations.xml)'
  c.option '--template FILE', 'Specify the template folder (default: lib/templates)'
  c.option '-o', '--output PATH', 'Specify the output folder (default: output)'
  c.action do |args, options|
    options.default taxonomy: 'taxonomy.xml',
                    destinations: 'destinations.xml',
                    template: 'lib/templates',
                    output: 'output'

    cwd = File.dirname(__FILE__)

    options.taxonomy = File.expand_path(options.taxonomy, cwd)
    options.destinations = File.expand_path(options.destinations, cwd)
    options.template = File.expand_path(options.template, cwd)
    options.output = File.expand_path(options.output, cwd)

    FileUtils.rm_rf(options.output)

    FileUtils.mkpath File.join(options.output, 'static')
    FileUtils.cp_r File.join(options.template, 'static/'), options.output

    render = HamlRender.new File.join(options.template, 'page.haml')

    PageMaker.new(options.output, render, options.taxonomy, options.destinations)
    .load_taxonomy
    .run
  end
end

default_command :help
