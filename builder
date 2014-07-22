#!/usr/bin/env ruby

require './lib/all'

require 'commander/import'

program :version, '0.0.1'
program :description, 'Lonely Planet Render'

command :render do |c|
  c.syntax = 'render render [options]'
  c.description = 'Render html files from dataset'

  c.option '-t', '--taxonomy FILE', 'Specify the path to taxonomy xml file'
  c.option '-d', '--destinations FILE', 'Specify the path to destination xml file'
  c.option '--template FILE', 'Specify the template folder'
  c.option '-o', '--output PATH', 'Specify the output folder'
  c.option '-w', '--web', 'Render page for web site'
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

    if options.web
      root_path = '/'
    else
      root_path = options.output
    end

    PageMaker.new(options.output, root_path, render, options.taxonomy, options.destinations)
    .load_taxonomy
    .run
  end
end

command :analyze do |c|
  c.syntax = 'render analyze [FILE...]'
  c.description = 'Analyze xml semantic hierarchy'
  c.action do |args, options|
    args.push('destinations.xml') if args.empty?

    args.each do |file|
      puts "Analyzing file #{file}..."
      SemanticNode.analyze(file).print_tree
    end
  end
end

default_command :help
