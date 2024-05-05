<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="floor" tilewidth="32" tileheight="32" tilecount="18" columns="9">
 <image source="../../resources/map/floortiles.png" width="288" height="64"/>
 <tile id="4">
  <properties>
   <property name="Trap" type="bool" value="true"/>
  </properties>
 </tile>
 <tile id="6">
  <properties>
   <property name="Collision" type="bool" value="true"/>
  </properties>
  <objectgroup draworder="index" id="5">
   <object id="5" x="2.28772" y="1.08366" width="28.8976" height="29.8608">
    <ellipse/>
   </object>
  </objectgroup>
 </tile>
 <tile id="7">
  <properties>
   <property name="Trap" type="bool" value="true"/>
  </properties>
 </tile>
 <tile id="8">
  <properties>
   <property name="Trap" type="bool" value="true"/>
  </properties>
 </tile>
 <tile id="17">
  <properties>
   <property name="Trap" type="bool" value="true"/>
  </properties>
 </tile>
</tileset>
