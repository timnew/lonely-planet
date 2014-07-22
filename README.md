lonely-planent
==============

[![Build Status](https://drone.io/github.com/timnew/lonely-planent/status.png)](https://drone.io/github.com/timnew/lonely-planent/latest)

Environment
-----------

The project is writen in Ruby 2.0. A `.ruby-version` file is provided, which could be recognized by latest `RVM` or `rbenv`.

Gems are managed by `Bundler`, `Gemfile` and `Gemfile.lock` are provided. `Gemset` is not used.


Quick Start
------------
After checked out or donwloaded the source code, execute following command to setup environment and verify whether it works:

```
	$ bundle install
	$ rake	
```

Builder
-----------

`builder` is the main entrace of the app, all the functions can be accessed via this cli tool.
`builder` provides a self contained document, execute:

```
  $ ./builder
```
or

```
  $ ./builder help
```
will display the document.

#### Build Pages

To render the pages, execute:

```
  $ ./builder render
```
A `output` folder will be created under current working directory, which contains all the generated files with all dependent resoruces, such `css` or `js` files.

** HINT ** For given `taxonomy.xml` and `destinations.xml`, the root page of generated site will be `output/Africa/index.html`

`builder render` provides some options to configure the render process, to know more execute:

```
  $ ./builder render --help
```

#### Analyze Destination Semantic Structure

Builder also provide a tool to analyze the xml semantic structure. It list the xml schema tree, min occurrance and max occurance of each node under a same parent, and the the occurance of the node across the whole file (weight).

To analyze the `destinations.xml`, execute

```
  $ ./builder analyze 
```

For more details, execute:

```
  $ ./builder analyze --help
```

Here is the schema tree for `destinations.xml` generated by the tool:

```
<root>[0:0] (0)
  destinations[0:1] (1)
    destination[24:24] (24)
      history[0:1] (5)
        history[1:1] (5)
          history[3:15] (38)
          overview[1:1] (5)
      introductory[1:1] (24)
        introduction[1:1] (24)
          overview[1:1] (24)
      practical_information[0:1] (8)
        health_and_safety[0:1] (7)
          before_you_go[0:8] (8)
          dangers_and_annoyances[0:4] (9)
          in_transit[0:2] (2)
          while_youre_there[0:5] (11)
        money_and_costs[1:1] (8)
          costs[0:1] (2)
          money[1:5] (15)
        visas[0:1] (5)
          overview[0:1] (4)
          other[0:4] (6)
          permits[0:1] (1)
      transport[0:1] (14)
        getting_around[0:1] (8)
          air[0:2] (4)
          bicycle[0:1] (1)
          boat[0:1] (1)
          car_and_motorcycle[0:3] (5)
          hitching[0:1] (2)
          local_transport[0:2] (4)
          overview[0:1] (5)
          train[0:1] (2)
          bus_and_tram[0:2] (3)
        getting_there_and_away[0:1] (11)
          air[0:7] (11)
          overview[0:1] (6)
          land[0:6] (6)
          bus_and_tram[0:3] (5)
        getting_there_and_around[0:1] (3)
          air[0:3] (3)
          bicycle[0:1] (1)
          bus_and_tram[0:1] (1)
          car_and_motorcycle[0:4] (4)
          local_transport[0:2] (2)
          overview[1:1] (3)
          train[0:1] (1)
      weather[0:1] (5)
        when_to_go[1:1] (5)
          climate[1:2] (6)
          overview[0:1] (1)
      work_live_study[0:1] (3)
        work[1:1] (3)
          business[1:1] (3)
          overview[0:1] (2)
      wildlife[0:1] (1)
        animals[1:1] (1)
          mammals[1:1] (1)
        birds[1:1] (1)
          overview[1:1] (1)
        endangered_species[1:1] (1)
          overview[1:1] (1)
        overview[1:1] (1)
          overview[1:1] (1)
        plants[1:1] (1)
          overview[1:1] (1)
```
**HINT:**

* the indention indicates the depth of the node
* [x:y] indicates the min occurance and max occurance of the node
* (w) indicates the weight of the node (How many times it occurs across the file)

Rake Tasks
-----------
`Rake` tasks is provided to developer on some development cases.

To know more details, execute:

```
  $ rake -T
```

### Tests

To run all the tests, execute:

```
  $ rake  
```

or

```
  $ rake spec
```
### Console

To start a console with all environment loaded, execute:

```
  $ rake pry
```

Design
------
* Xml files are parsed into `models`. 
* `Actors` consumes the `models` and `view models` and generate pages. 
* `View models` provide an abstraction layer beyond the `html`, it describe the page in a specific `DSL`.
* `Templates` provide the `haml template` and `static assets` for the pages

### Taxonomy Nodes

Taxonomy tree is represented by `Taxonomy` and `TaxonomyNode` tree.

### Destinations

Destinations are loaded into `Destination` and `DestinationNode` tree.

To avoid `out of memory` exception when processing large `destinations.xml` file, the data is loaded in SAX way. **Only** the data is under processing is stored in memory, and will be dropped after prcoessed. Besides **only** the destination described in `taxonomy.xml` is loaded and processed.

### Page

`Page` contains `navigation items` and `sections`. 

#### Naivgation Items

`Navigation Items` is built from `taxonomy tree`. It contains it self, the region it blongs to, the territories it includes.

#### Sections

`Sections` are the main information displayed on the page, each section is represented in a box. 

Each `section` contains a `title` and a bunch of `blocks`. 

#### Blocks

`Block` is a group of paragraphs in a `section`, it might or might not have title.

A `paragraph limit` can be set to `block`. And the paragraphs beyond the `limit` will be hidden in a colapsable region by default. If user is interested, the can expand the region by click the link to expand the region.

Known Issues
------------
1. The app might nor work properly on Windows
2. The generated pages might not work after moved into another folder, because they locate the javascript, css and other related resources via absolute path.
3. No build script is provided for coffeescripts
