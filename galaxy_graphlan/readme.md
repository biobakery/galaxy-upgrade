#Installation instructions for GraPhLan in a Galaxy environment.
These instructions require the Mercurial versioning system, galaxy, and an internet connection.

#For general information about GraphLan please refer to:
```
https://github.com/biobakery/graphlan
```
#Installation procedure: Graphlan under Galaxy


Requirements:
```
  biopython, python-dev, matplotlib and numpy are requirements for graphlan.
 
	If you are missing any of these requirements, see installation instructions as follows:
		Biopython: http://biopython.org/wiki/Main_Page 
		python-dev:  sudo apt-get install python-dev  
		numpy: http://www.scipy.org/install.html 
		matplotlib:  sudo apt-get install python-matplotlib
```	
Clone this repository somewhere: It will create a directory named "galaxy_graphlan"

In the  "galaxy-dist/tools" directory install graphlan by typing in a terminal:
```
git clone https://github.com/biobakery/graphlan.git
```

Copy all members from the graphlan_galaxy on to /galaxy-dist/tools/graphlan

```
cd ~/galaxy-dist/tools/graphlan
cp ~/galaxy_graphlan/* .
```

Update member tool_conf.xml  in the galaxy directory adding the following: 
```
  <section name="GraPhlAn" id="graphlan">
    <tool file="graphlan/graphlan_annotate.xml" />
    <tool file="graphlan/graphlan_ring_annotate.xml" />
    <tool file="graphlan/graphlan.xml" /> 
  </section>
```

Update member datatypes_conf.xml  in the galaxy directory adding the following:
```
    <datatype extension="circl" type="galaxy.datatypes.data:Text" subclass="true" display_in_upload="true"/>
```	
Copy the library pyphlan to your galaxy-dist/lib
	(Please copy it as a library with all the members)
```
	 cd ~/galaxy-dist/lib
	 cp -r ~/galaxy-dist/tools/graphlan/pyphlan .
```	
Recycle galaxy
