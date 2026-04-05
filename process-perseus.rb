#! /usr/bin/env ruby
# Ruby version 3.1
# Nokogiri version 1.18

require 'nokogiri'
require 'csv'
require 'optparse'

FEATURES = %w[ov an gn adpn]
TYPES = %w[perseus papygreek]

def metadata_from_key(key)
{
    "treebanks/01-homer/tlg0012.tlg001.perseus-grc1.tb.xml": {
      "author": "Homer",
      "year": -750,
      "genre": "Epic",
      "work": "Iliad"
    },
    "treebanks/01-homer/tlg0012.tlg002.perseus-grc1.tb.xml": {
      "author": "Homer",
      "year": -725,
      "genre": "Epic",
      "work": "Odyssey"
    },
    "treebanks/02-hesiod/tlg0020.tlg001.perseus-grc1.tb.xml": {
      "author": "Hesiod",
      "year": -700,
      "genre": "Epic",
      "work": "Theogony"
    },
    "treebanks/02-hesiod/tlg0020.tlg002.perseus-grc1.tb.xml": {
      "author": "Hesiod",
      "year": -700,
      "genre": "Epic",
      "work": "Works and Days"
    },
    "treebanks/02-hesiod/tlg0020.tlg003.perseus-grc1.tb.xml": {
      "author": "Hesiod",
      "year": -700,
      "genre": "Epic",
      "work": "Shield of Heracles"
    },
    "treebanks/03-homeric-hymn/tlg0013.tlg002.perseus-grc1.tb.xml": {
      "author": "Homeric Hymn",
      "year": -600,
      "genre": "Epic",
      "work": "Homeric Hymn to Demeter"
    },
    "treebanks/04-aesop/tlg0096.tlg002.opp-grc2.1-53.tb.xml": {
      "author": "Aesop",
      "year": -550,
      "genre": "Prose",
      "work": "Fables"
    },
    "treebanks/05-aeschylus/tlg0085.tlg001.perseus-grc2.tb.xml": {
      "author": "Aeschylus",
      "year": -463,
      "genre": "Drama",
      "work": "Suppliants"
    },
    "treebanks/05-aeschylus/tlg0085.tlg002.perseus-grc2.tb.xml": {
      "author": "Aeschylus",
      "year": -472,
      "genre": "Drama",
      "work": "Persians"
    },
    "treebanks/05-aeschylus/tlg0085.tlg003.perseus-grc2.tb.xml": {
      "author": "Aeschylus",
      "year": -450,
      "genre": "Drama",
      "work": "Prometheus Bound"
    },
    "treebanks/05-aeschylus/tlg0085.tlg004.perseus-grc2.tb.xml": {
      "author": "Aeschylus",
      "year": -467,
      "genre": "Drama",
      "work": "Seven Against Thebes"
    },
    "treebanks/05-aeschylus/tlg0085.tlg005.perseus-grc1.tb.xml": {
      "author": "Aeschylus",
      "year": -458,
      "genre": "Drama",
      "work": "Agamemnon"
    },
    "treebanks/05-aeschylus/tlg0085.tlg006.perseus-grc2.tb.xml": {
      "author": "Aeschylus",
      "year": -458,
      "genre": "Drama",
      "work": "Libation Bearers"
    },
    "treebanks/05-aeschylus/tlg0085.tlg007.perseus-grc1.tb.xml": {
      "author": "Aeschylus",
      "year": -458,
      "genre": "Drama",
      "work": "Eumenides"
    },
    "treebanks/06-sophocles/tlg0011.tlg001.perseus-grc2.tb.xml": {
      "author": "Sophocles",
      "year": -440,
      "genre": "Drama",
      "work": "Women of Trachis"
    },
    "treebanks/06-sophocles/tlg0011.tlg002.perseus-grc2.tb.xml": {
      "author": "Sophocles",
      "year": -441,
      "genre": "Drama",
      "work": "Antigone"
    },
    "treebanks/06-sophocles/tlg0011.tlg003.perseus-grc1.tb.xml": {
      "author": "Sophocles",
      "year": -442,
      "genre": "Drama",
      "work": "Ajax"
    },
    "treebanks/06-sophocles/tlg0011.tlg004.perseus-grc1.tb.xml": {
      "author": "Sophocles",
      "year": -429,
      "genre": "Drama",
      "work": "Oedipus Tyrannus"
    },
    "treebanks/06-sophocles/tlg0011.tlg005.perseus-grc2.tb.xml": {
      "author": "Sophocles",
      "year": -418,
      "genre": "Drama",
      "work": "Electra"
    },
    "treebanks/07-herodotus/tlg0016.tlg001.perseus-grc1.1.tb.xml": {
      "author": "Herodotus",
      "year": -430,
      "genre": "History",
      "work": "Histories"
    },
    "treebanks/08-thucydides/tlg0003.tlg001.perseus-grc1.1.tb.xml": {
      "author": "Thucydides",
      "year": -404,
      "genre": "History",
      "work": "History of the Peloponnesian War"
    },
    "treebanks/09-lysias/tlg0540.tlg001.perseus-grc1.tb.xml": {
      "author": "Lysias",
      "year": -400,
      "genre": "Oratory",
      "work": "On the Murder of Eratosthenes"
    },
    "treebanks/09-lysias/tlg0540.tlg014.perseus-grc1.tb.xml": {
      "author": "Lysias",
      "year": -395,
      "genre": "Oratory",
      "work": "Against Alcibiades 1"
    },
    "treebanks/09-lysias/tlg0540.tlg015.perseus-grc1.tb.xml": {
      "author": "Lysias",
      "year": -395,
      "genre": "Oratory",
      "work": "Against Alcibiades 2"
    },
    "treebanks/09-lysias/tlg0540.tlg023.perseus-grc1.tb.xml": {
      "author": "Lysias",
      "year": -399,
      "genre": "Oratory",
      "work": "Against Pancleon"
    },
    "treebanks/10-plato/tlg0059.tlg001.perseus-grc1.tb.xml": {
      "author": "Plato",
      "year": -399,
      "genre": "Prose",
      "work": "Euthyphro"
    },
    "treebanks/11-polybius/tlg0543.tlg001.perseus-grc1.tb.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "treebanks/12-apollodorus/tlg0548.tlg001.perseus-grc1.1.1.1-1.4.1.tb.xml": {
      "author": "Ps. Apollodorus",
      "year": 100,
      "genre": "Prose",
      "work": "Library"
    },
    "treebanks/13-diodorus/tlg0060.tlg001.perseus-grc3.11.tb.xml": {
      "author": "Diodorus Siculus",
      "year": -60,
      "genre": "History",
      "work": "Library of History"
    },
    "treebanks/14-plutarch/tlg0007.tlg004.perseus-grc1.tb.xml": {
      "author": "Plutarch",
      "year": 100,
      "genre": "History",
      "work": "Lycurgus"
    },
    "treebanks/14-plutarch/tlg0007.tlg015.perseus-grc1.tb.xml": {
      "author": "Plutarch",
      "year": 100,
      "genre": "History",
      "work": "Alcibiades"
    },
    "treebanks/15-athenaeus/tlg0008.tlg001.perseus-grc1.12.tb.xml": {
      "author": "Athenaeus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "treebanks/15-athenaeus/tlg0008.tlg001.perseus-grc1.13.tb.xml": {
      "author": "Athenaeus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/aeschines-1-1-50-bu1.xml": {
      "author": "Aeschines",
      "year": -345,
      "genre": "Oratory",
      "work": "Against Timarchus"
    },
    "gorman-trees/public/xml/aeschines-1-101-150-bu1.xml": {
      "author": "Aeschines",
      "year": -345,
      "genre": "Oratory",
      "work": "Against Timarchus"
    },
    "gorman-trees/public/xml/aeschines-1-151-196-bu1.xml": {
      "author": "Aeschines",
      "year": -345,
      "genre": "Oratory",
      "work": "Against Timarchus"
    },
    "gorman-trees/public/xml/aeschines-1-51-100-bu1.xml": {
      "author": "Aeschines",
      "year": -345,
      "genre": "Oratory",
      "work": "Against Timarchus"
    },
    "gorman-trees/public/xml/antiphon-1-bu2.xml": {
      "author": "Antiphon",
      "year": -419,
      "genre": "Oratory",
      "work": "Against the Stepmother"
    },
    "gorman-trees/public/xml/antiphon-2-bu2.xml": {
      "author": "Antiphon",
      "year": -430,
      "genre": "Oratory",
      "work": "First Tetralogy"
    },
    "gorman-trees/public/xml/antiphon-5-bu2.xml": {
      "author": "Antiphon",
      "year": -415,
      "genre": "Oratory",
      "work": "On the Murder of Herodes"
    },
    "gorman-trees/public/xml/antiphon-6-bu2.xml": {
      "author": "Antiphon",
      "year": -419,
      "genre": "Oratory",
      "work": "On the Choreutes"
    },
    "gorman-trees/public/xml/appian-bc-1-0-1-4-bu1.xml": {
      "author": "Appian",
      "year": 150,
      "genre": "History",
      "work": "Civil Wars"
    },
    "gorman-trees/public/xml/appian-bc-1-11-14-bu1.xml": {
      "author": "Appian",
      "year": 150,
      "genre": "History",
      "work": "Civil Wars"
    },
    "gorman-trees/public/xml/appian-bc-1-5-7-bu1.xml": {
      "author": "Appian",
      "year": 150,
      "genre": "History",
      "work": "Civil Wars"
    },
    "gorman-trees/public/xml/appian-bc-1-8-10-bu1.xml": {
      "author": "Appian",
      "year": 150,
      "genre": "History",
      "work": "Civil Wars"
    },
    "gorman-trees/public/xml/aristotle-politics-book-1-bu1.xml": {
      "author": "Aristotle",
      "year": -335,
      "genre": "Prose",
      "work": "Politics"
    },
    "gorman-trees/public/xml/aristotle-politics-book-2-bu2.xml": {
      "author": "Aristotle",
      "year": -335,
      "genre": "Prose",
      "work": "Politics"
    },
    "gorman-trees/public/xml/athen12-1-9-2019.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen12-10-19-2019.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen12-20-29-2019.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen12-20-29-jan-15.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen12-30-39-2019.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen12-30-39-jan-15.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen12-40-49-2019.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen12-40-49-jan-15.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen12-50-59-2019.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen12-50-59-jan-15.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen12-60-69-2019.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen12-60-69-jan-15.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen12-70-81-2019.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen12-70-81-jan-15.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen13-1-9-2019.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen13-1-9-jan-15.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen13-10-19-2019.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen13-10-19-jan-15.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen13-20-29-2019.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen13-20-29-jan-15.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen13-30-39-2019.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen13-30-39-jan-15.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen13-40-49-2019.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen13-40-49-jan-15.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen13-50-59-2019.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen13-50-59-jan-15.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen13-60-69-2019.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen13-60-69-jan-15.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen13-70-79-2019.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen13-70-79-jan-15.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen13-80-89-2019.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen13-80-89-jan-15.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen13-90-95-2019.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/athen13-90-95-jan-15.xml": {
      "author": "Ps. Apollodorus",
      "year": 200,
      "genre": "Prose",
      "work": "Deipnosophistae"
    },
    "gorman-trees/public/xml/dem-59-neaira-2019.xml": {
      "author": "Demosthenes",
      "year": -343,
      "genre": "Oratory",
      "work": "Against Neaira"
    },
    "gorman-trees/public/xml/demosthenes-1-bu1.xml": {
      "author": "Demosthenes",
      "year": -351,
      "genre": "Oratory",
      "work": "First Olynthiac"
    },
    "gorman-trees/public/xml/demosthenes-18-1-50-bu2.xml": {
      "author": "Demosthenes",
      "year": -330,
      "genre": "Oratory",
      "work": "On the Crown"
    },
    "gorman-trees/public/xml/demosthenes-18-101-150-bu2.xml": {
      "author": "Demosthenes",
      "year": -330,
      "genre": "Oratory",
      "work": "On the Crown"
    },
    "gorman-trees/public/xml/demosthenes-18-151-200-bu2.xml": {
      "author": "Demosthenes",
      "year": -330,
      "genre": "Oratory",
      "work": "On the Crown"
    },
    "gorman-trees/public/xml/demosthenes-18-201-275-bu1.xml": {
      "author": "Demosthenes",
      "year": -330,
      "genre": "Oratory",
      "work": "On the Crown"
    },
    "gorman-trees/public/xml/demosthenes-18-276-324-bu1.xml": {
      "author": "Demosthenes",
      "year": -330,
      "genre": "Oratory",
      "work": "On the Crown"
    },
    "gorman-trees/public/xml/demosthenes-18-51-100-bu1.xml": {
      "author": "Demosthenes",
      "year": -330,
      "genre": "Oratory",
      "work": "On the Crown"
    },
    "gorman-trees/public/xml/demosthenes-4-phil1-bu1.xml": {
      "author": "Demosthenes",
      "year": -351,
      "genre": "Oratory",
      "work": "First Philippic"
    },
    "gorman-trees/public/xml/demosthenes-46-tree.xml": {
      "author": "Demosthenes",
      "year": -360,
      "genre": "Oratory",
      "work": "Against Stephanus 2"
    },
    "gorman-trees/public/xml/demosthenes-47-tree.xml": {
      "author": "Demosthenes",
      "year": -360,
      "genre": "Oratory",
      "work": "Against Evergus and Mnesibulus"
    },
    "gorman-trees/public/xml/demosthenes-49-tree.xml": {
      "author": "Demosthenes",
      "year": -362,
      "genre": "Oratory",
      "work": "Against Timotheus"
    },
    "gorman-trees/public/xml/demosthenes-50-tree.xml": {
      "author": "Demosthenes",
      "year": -362,
      "genre": "Oratory",
      "work": "Against Polycles"
    },
    "gorman-trees/public/xml/demosthenes-52-tree.xml": {
      "author": "Demosthenes",
      "year": -370,
      "genre": "Oratory",
      "work": "Against Callippus"
    },
    "gorman-trees/public/xml/demosthenes-53-tree.xml": {
      "author": "Demosthenes",
      "year": -368,
      "genre": "Oratory",
      "work": "Against Nicostratus"
    },
    "gorman-trees/public/xml/diodsic-11-1-20-bu4.xml": {
      "author": "Diodorus Siculus",
      "year": -60,
      "genre": "History",
      "work": "Library of History"
    },
    "gorman-trees/public/xml/diodsic-11-81-92-bu1.xml": {
      "author": "Diodorus Siculus",
      "year": -60,
      "genre": "History",
      "work": "Library of History"
    },
    "gorman-trees/public/xml/diodsic11-21-40-bu2.xml": {
      "author": "Diodorus Siculus",
      "year": -60,
      "genre": "History",
      "work": "Library of History"
    },
    "gorman-trees/public/xml/diodsic11-41-60-bu1.xml": {
      "author": "Diodorus Siculus",
      "year": -60,
      "genre": "History",
      "work": "Library of History"
    },
    "gorman-trees/public/xml/diodsic11-61-80-bu1.xml": {
      "author": "Diodorus Siculus",
      "year": -60,
      "genre": "History",
      "work": "Library of History"
    },
    "gorman-trees/public/xml/dion-hal-1-1-15-bu2.xml": {
      "author": "Dionysius of Halicarnassus",
      "year": -7,
      "genre": "History",
      "work": "Roman Antiquities"
    },
    "gorman-trees/public/xml/dion-hal-1-16-30-bu1.xml": {
      "author": "Dionysius of Halicarnassus",
      "year": -7,
      "genre": "History",
      "work": "Roman Antiquities"
    },
    "gorman-trees/public/xml/dion-hal-1-31-45-bu1.xml": {
      "author": "Dionysius of Halicarnassus",
      "year": -7,
      "genre": "History",
      "work": "Roman Antiquities"
    },
    "gorman-trees/public/xml/dion-hal-1-46-60-bu1.xml": {
      "author": "Dionysius of Halicarnassus",
      "year": -7,
      "genre": "History",
      "work": "Roman Antiquities"
    },
    "gorman-trees/public/xml/dion-hal-1-61-75-bu1.xml": {
      "author": "Dionysius of Halicarnassus",
      "year": -7,
      "genre": "History",
      "work": "Roman Antiquities"
    },
    "gorman-trees/public/xml/dion-hal-1-76-90-bu1.xml": {
      "author": "Dionysius of Halicarnassus",
      "year": -7,
      "genre": "History",
      "work": "Roman Antiquities"
    },
    "gorman-trees/public/xml/hdt-1-1-19-bu3-2019.xml": {
      "author": "Herodotus",
      "year": -430,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/hdt-1-100-119-bu3-2019.xml": {
      "author": "Herodotus",
      "year": -430,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/hdt-1-120-149-bu2-2019.xml": {
      "author": "Herodotus",
      "year": -430,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/hdt-1-150-169-bu3-2019.xml": {
      "author": "Herodotus",
      "year": -430,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/hdt-1-170-189-bu2-2019.xml": {
      "author": "Herodotus",
      "year": -430,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/hdt-1-190-216-bu2-2019.xml": {
      "author": "Herodotus",
      "year": -430,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/hdt-1-20-39-bu2-2019.xml": {
      "author": "Herodotus",
      "year": -430,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/hdt-1-40-59-bu2-2019.xml": {
      "author": "Herodotus",
      "year": -430,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/hdt-1-60-79-bu2-2019.xml": {
      "author": "Herodotus",
      "year": -430,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/hdt-1-80-99-bu5-2019.xml": {
      "author": "Herodotus",
      "year": -430,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/josephus-bj-1-1-2-bu1.xml": {
      "author": "Josephus",
      "year": 75,
      "genre": "History",
      "work": "Jewish War"
    },
    "gorman-trees/public/xml/josephus-bj-1-11-15-bu1.xml": {
      "author": "Josephus",
      "year": 75,
      "genre": "History",
      "work": "Jewish War"
    },
    "gorman-trees/public/xml/josephus-bj-1-16-20-bu1.xml": {
      "author": "Josephus",
      "year": 75,
      "genre": "History",
      "work": "Jewish War"
    },
    "gorman-trees/public/xml/josephus-bj-1-21-25-bu1.xml": {
      "author": "Josephus",
      "year": 75,
      "genre": "History",
      "work": "Jewish War"
    },
    "gorman-trees/public/xml/josephus-bj-1-3-5-bu2.xml": {
      "author": "Josephus",
      "year": 75,
      "genre": "History",
      "work": "Jewish War"
    },
    "gorman-trees/public/xml/josephus-bj-1-6-10-bu1.xml": {
      "author": "Josephus",
      "year": 75,
      "genre": "History",
      "work": "Jewish War"
    },
    "gorman-trees/public/xml/lysias-1-bu1.xml": {
      "author": "Lysias",
      "year": -400,
      "genre": "Oratory",
      "work": "On the Murder of Eratosthenes"
    },
    "gorman-trees/public/xml/lysias-12-bu1.xml": {
      "author": "Lysias",
      "year": -403,
      "genre": "Oratory",
      "work": "Against Eratosthenes"
    },
    "gorman-trees/public/xml/lysias-13-bu1.xml": {
      "author": "Lysias",
      "year": -399,
      "genre": "Oratory",
      "work": "Against Agoratus"
    },
    "gorman-trees/public/xml/lysias-14-bu1.xml": {
      "author": "Lysias",
      "year": -395,
      "genre": "Oratory",
      "work": "Against Alcibiades 1"
    },
    "gorman-trees/public/xml/lysias-15.xml": {
      "author": "Lysias",
      "year": -395,
      "genre": "Oratory",
      "work": "Against Alcibiades 2"
    },
    "gorman-trees/public/xml/lysias-19-bu1.xml": {
      "author": "Lysias",
      "year": -388,
      "genre": "Oratory",
      "work": "On the Property of Aristophanes"
    },
    "gorman-trees/public/xml/lysias-23-bu1.xml": {
      "author": "Lysias",
      "year": -399,
      "genre": "Oratory",
      "work": "Against Pancleon"
    },
    "gorman-trees/public/xml/plato-apology.xml": {
      "author": "Plato",
      "year": -399,
      "genre": "Prose",
      "work": "Apology"
    },
    "gorman-trees/public/xml/plut-alcib-1-17-bu1.xml": {
      "author": "Plutarch",
      "year": 100,
      "genre": "History",
      "work": "Alcibiades"
    },
    "gorman-trees/public/xml/plut-alcib-18-39-bu1.xml": {
      "author": "Plutarch",
      "year": 100,
      "genre": "History",
      "work": "Alcibiades"
    },
    "gorman-trees/public/xml/plut-fortuna-romanorum-bu1.xml": {
      "author": "Plutarch",
      "year": 100,
      "genre": "History",
      "work": "On the Fortune of the Romans"
    },
    "gorman-trees/public/xml/plutarch-alex-fort-aut-virt-bu2.xml": {
      "author": "Plutarch",
      "year": 100,
      "genre": "History",
      "work": "On the Fortune or Virtue of Alexander"
    },
    "gorman-trees/public/xml/plutarch-lycurgus-1-15-bu4.xml": {
      "author": "Plutarch",
      "year": 100,
      "genre": "History",
      "work": "Lycurgus"
    },
    "gorman-trees/public/xml/plutarch-lycurgus-16-31-bu2.xml": {
      "author": "Plutarch",
      "year": 100,
      "genre": "History",
      "work": "Lycurgus"
    },
    "gorman-trees/public/xml/polybius-10-1-10-bu1.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius-10-11-20-bu1.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius-10-21-35-bu2.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius-10-36-49-bu1.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius-2-1-10-bu1.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius-2-11-20-bu1.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius-2-21-30-bu2.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius-2-31-40-bu2.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius-2-41-50-bu1.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius-2-51-60-bu1.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius-2-61-71-bu2.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius-21-1-10-bu1.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius-21-11-20-bu1.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius-21-21-30-bu1.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius-21-31-47-bu1.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius-6-16-30-bu1.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius-6-2-15-bu1.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius-6-31-45-bu1.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius-6-46-58-bu1.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius-9-1-20-bu1.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius-9-21-33-bu1.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius-9-34-45-bu1.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius1-1-9-2017.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius1-10-19-2017.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius1-20-29-2017.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius1-30-39-2017.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius1-40-49-2017.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius1-50-59-2017.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius1-60-69-2017.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius1-70-79-2017.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/polybius1-80-88-2017.xml": {
      "author": "Polybius",
      "year": -150,
      "genre": "History",
      "work": "Histories"
    },
    "gorman-trees/public/xml/ps-xen-ath-pol-bu2.xml": {
      "author": "Ps. Xenophon",
      "year": -424,
      "genre": "Prose",
      "work": "Constitution of the Athenians"
    },
    "gorman-trees/public/xml/thuc-1-1-20-bu5.xml": {
      "author": "Thucydides",
      "year": -404,
      "genre": "History",
      "work": "History of the Peloponnesian War"
    },
    "gorman-trees/public/xml/thuc-1-101-120-bu2.xml": {
      "author": "Thucydides",
      "year": -404,
      "genre": "History",
      "work": "History of the Peloponnesian War"
    },
    "gorman-trees/public/xml/thuc-1-121-146-bu3.xml": {
      "author": "Thucydides",
      "year": -404,
      "genre": "History",
      "work": "History of the Peloponnesian War"
    },
    "gorman-trees/public/xml/thuc-1-21-40-bu4.xml": {
      "author": "Thucydides",
      "year": -404,
      "genre": "History",
      "work": "History of the Peloponnesian War"
    },
    "gorman-trees/public/xml/thuc-1-41-60-bu3.xml": {
      "author": "Thucydides",
      "year": -404,
      "genre": "History",
      "work": "History of the Peloponnesian War"
    },
    "gorman-trees/public/xml/thuc-1-61-80-bu3.xml": {
      "author": "Thucydides",
      "year": -404,
      "genre": "History",
      "work": "History of the Peloponnesian War"
    },
    "gorman-trees/public/xml/thuc-1-81-100-bu2.xml": {
      "author": "Thucydides",
      "year": -404,
      "genre": "History",
      "work": "History of the Peloponnesian War"
    },
    "gorman-trees/public/xml/thuc-3-1-20-bu1.xml": {
      "author": "Thucydides",
      "year": -404,
      "genre": "History",
      "work": "History of the Peloponnesian War"
    },
    "gorman-trees/public/xml/thuc-3-21-40-bu1.xml": {
      "author": "Thucydides",
      "year": -404,
      "genre": "History",
      "work": "History of the Peloponnesian War"
    },
    "gorman-trees/public/xml/xen-cyr-1-1-2-bu1.xml": {
      "author": "Xenophon",
      "year": -370,
      "genre": "History",
      "work": "Cyropaedia"
    },
    "gorman-trees/public/xml/xen-cyr-1-3-4-bu1.xml": {
      "author": "Xenophon",
      "year": -370,
      "genre": "History",
      "work": "Cyropaedia"
    },
    "gorman-trees/public/xml/xen-cyr-1-5-bu1.xml": {
      "author": "Xenophon",
      "year": -370,
      "genre": "History",
      "work": "Cyropaedia"
    },
    "gorman-trees/public/xml/xen-cyr-1-6-bu1.xml": {
      "author": "Xenophon",
      "year": -370,
      "genre": "History",
      "work": "Cyropaedia"
    },
    "gorman-trees/public/xml/xen-cyr-7-1-3-tree.xml": {
      "author": "Xenophon",
      "year": -370,
      "genre": "History",
      "work": "Cyropaedia"
    },
    "gorman-trees/public/xml/xen-cyr-7-4-5-tree.xml": {
      "author": "Xenophon",
      "year": -370,
      "genre": "History",
      "work": "Cyropaedia"
    },
    "gorman-trees/public/xml/xen-cyr-8-1-8-4-bu1.xml": {
      "author": "Xenophon",
      "year": -370,
      "genre": "History",
      "work": "Cyropaedia"
    },
    "gorman-trees/public/xml/xen-cyr-8-5-7-bu1.xml": {
      "author": "Xenophon",
      "year": -370,
      "genre": "History",
      "work": "Cyropaedia"
    },
    "gorman-trees/public/xml/xen-cyr-8-8-bu1.xml": {
      "author": "Xenophon",
      "year": -370,
      "genre": "History",
      "work": "Cyropaedia"
    },
    "gorman-trees/public/xml/xen-hell-1-1-4-bu2.xml": {
      "author": "Xenophon",
      "year": -362,
      "genre": "History",
      "work": "Hellenica"
    },
    "gorman-trees/public/xml/xen-hell-1-5-7-bu1.xml": {
      "author": "Xenophon",
      "year": -362,
      "genre": "History",
      "work": "Hellenica"
    },
    "gorman-trees/public/xml/xen-hell-2-bu1.xml": {
      "author": "Xenophon",
      "year": -362,
      "genre": "History",
      "work": "Hellenica"
    },
    "gorman-trees/public/xml/xen-hell-3-bu1.xml": {
      "author": "Xenophon",
      "year": -362,
      "genre": "History",
      "work": "Hellenica"
    }
  }[key.to_sym]
end

def letter_to_mood(letter)
  {
    'i' => 'Indicative',
    's' => 'Subjunctive',
    'o' => 'Optative',
    'n' => 'Infinitive',
    'm' => 'Imperative',
    'p' => 'Participle',
  }[letter]
end

# Convert from parsed XML to tree
def transform_sentence(node)
  words = node.xpath('./word').sort_by { |w| w[:id].to_i }
  sentence = {}
  words.each { |w| sentence[w[:id]] = { children: [] } }

  words.each do |w|
    word = sentence[w[:id]]

    word[:id] = w[:id] || w[:id_orig]
    word[:head] = w[:head] || w[:head_orig]
    word[:postag] = w[:postag] || w[:postag_orig]
    word[:relation] = w[:relation] || w[:relation_orig]
    word[:lemma] = w[:lemma] || w[:lemma_orig]
    word[:artificial] = w[:artificial] || w[:artificial_orig]

    if sentence.member?(word[:head])
      sentence[word[:head]][:children].push(w[:id])
    end
  end

  [node[:id], sentence]
end

# Take sentence in tree format and convert to CSV line
def sentence_to_csv(sentence, options)
  heads = {}
  csv = []

  sentence.each do |id, node|
    next if node[:artificial]

    case options[:feature]
    when 'ov'
      if node[:postag][0] == 'v'
        mood = letter_to_mood(node[:postag][4])
        next unless mood

        heads[id] ||= {}
        heads[id][:order] ||= {}
        heads[id][:order][:v] = heads[id][:order].size + 1
        heads[id][:mood] = mood

        if node[:relation] == 'PRED' || node[:relation] == 'PRED_CO'
          heads[id][:clause] = 'main'
        else
          heads[id][:clause] = 'subordinate'
        end
      elsif node[:relation] == 'OBJ' && node[:postag][7] == 'a' && node[:postag][0] == 'n'
        head = (heads[node[:head]] ||= {})
        head[:order] ||= {}
        head[:order][:o] ||= head[:order].size + 1
      end

    when 'an'
      if node[:postag][0] == 'n'
        heads[id] ||= {}
        heads[id][:order] ||= {}
        heads[id][:order][:n] = heads[id][:order].size + 1
      elsif node[:postag][0] == 'a' && node[:relation] == 'ATR'
        head = (heads[node[:head]] ||= {})
        head[:order] ||= {}
        head[:order][:a] ||= head[:order].size + 1
      end

    when 'gn'
      if node[:postag][0] == 'n' && node[:postag][7] != 'g'
        heads[id] ||= {}
        heads[id][:order] ||= {}
        heads[id][:order][:n] = heads[id][:order].size + 1
      elsif node[:postag][0] == 'n' && node[:postag][7] == 'g' && node[:relation] == 'ATR'
        head = (heads[node[:head]] ||= {})
        head[:order] ||= {}
        head[:order][:g] ||= head[:order].size + 1
      end

    when 'adpn'
      if node[:postag][0] == 'r' && node[:relation] == 'AuxP'
        heads[id] ||= {}
        heads[id][:order] ||= {}
        heads[id][:order][:a] = heads[id][:order].size + 1
      elsif node[:postag][0] == 'n'
        head = (heads[node[:head]] ||= {})
        head[:order] ||= {}
        head[:order][:n] ||= head[:order].size + 1
      end
    end
  end

  heads.each do |_, head|
    case options[:feature]
    when 'ov'
      next unless (order = head[:order]) && order[:v] && order[:o]

      label = {
        [1, 2] => 'VO',
        [2, 1] => 'OV',
      }[[order[:v], order[:o]]]

      csv.push([head[:clause], head[:mood], label])

    when 'an'
      next unless (order = head[:order]) && order[:n] && order[:a]

      label = {
        [1, 2] => 'NA',
        [2, 1] => 'AN',
      }[[order[:n], order[:a]]]

      csv.push([label])

    when 'gn'
      next unless (order = head[:order]) && order[:n] && order[:g]

      label = {
        [1, 2] => 'NG',
        [2, 1] => 'GN',
      }[[order[:n], order[:g]]]

      csv.push([label])

    when 'adpn'
      next unless (order = head[:order]) && order[:n] && order[:a]

      label = {
        [1, 2] => 'NA',
        [2, 1] => 'AN',
      }[[order[:n], order[:a]]]

      csv.push([label])
    end
  end

  csv
end

options = {
  feature: FEATURES.first,
  type: nil,
}

OptionParser.new do |opts|
  opts.banner = "Usage: #{$PROGRAM_NAME} --type TYPE [--feature FEATURE] file1.xml [file2.xml ...]"

  opts.on('--feature FEATURE', FEATURES, "Feature: #{FEATURES.join(', ')} (default: #{options[:feature]})") do |feature|
    options[:feature] = feature
  end

  opts.on('--type TYPE', TYPES, "Input type: #{TYPES.join(', ')} (required)") do |type|
    options[:type] = type
  end

  opts.on('-h', '--help', 'Show this message') do
    puts opts
    exit
  end
end.parse!(ARGV)

errors = []
if options[:type].nil?
  errors << "Error: --type is required and must be one of: #{TYPES.join(', ')}"
end

if ARGV.empty?
  errors << 'Error: you must provide at least one XML filename'
end

if errors.any?
  errors.each { |e| puts e }
  exit 1
end

ARGV.each do |filename|
  xml = File.open(filename) { |f| Nokogiri::XML(f) }

  case options[:type]
  when 'perseus'
    meta = metadata_from_key(filename)
    next unless meta

    author = meta[:author]
    work = meta[:work]
    year = meta[:year]
    genre = meta[:genre]

  when 'papygreek'
    author = 'Anonymous'
    work = 'Papyrus'
    genre = 'Papyrus'
    meta = xml.xpath('//document_meta').first

    date_not_before = nil
    date_not_after = nil

    if meta && meta['date_not_before'] && meta['date_not_before'] != ''
      date_not_before = meta['date_not_before'].to_i
    end
    if meta && meta['date_not_after'] && meta['date_not_after'] != ''
      date_not_after = meta['date_not_after'].to_i
    end

    year = date_not_before || date_not_after
    year = (date_not_after + date_not_before) / 2 if date_not_before && date_not_after
    next unless year
  end

  xml.xpath('//sentence')
    .map { |n| transform_sentence(n) }
    .map { |id, s| [sentence_to_csv(s, options), id] }
    .each { |c, id| c.each { |r| print CSV.generate_line([filename, author, work, year, genre, id] + r) } }
end
