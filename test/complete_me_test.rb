require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'

require './lib/complete_me.rb'

class CompleteMeTest < MiniTest::Test
  def test_completeme_exists
    completion = CompleteMe.new
    assert completion
  end

  def test_completeme_starts_without_word_count
    completion = CompleteMe.new
    assert_equal 0, completion.count
  end

  def test_completeme_word_count_increments_with_insert
    completion = CompleteMe.new
    completion.insert("pizza")
    assert_equal 1, completion.count
    completion.insert("pizzeria")
    assert_equal 2, completion.count
    completion.insert("pi")
    assert_equal 3, completion.count
  end

  def test_completeme_word_insert_adds_nodes
    completion = CompleteMe.new
    completion.insert("pizza")
    refute_nil completion.find_node("p")
  end

  def test_find_letters_returns_no_suggestions_if_not_found
    completion = CompleteMe.new

    result = completion.suggest("a")
    expected = "No Suggestions"

    assert_equal expected, result

    added = completion.insert('a')
    assert_equal "a", completion.head.children[:a].letter
    result_2 = completion.suggest("ab")
    assert_equal expected, result_2
  end

  def test_suggest_returns_array_of_options_one_word
    completion = CompleteMe.new
    completion.insert("pizza")
    result = completion.suggest("piz")
    assert_equal ["pizza"], result
  end

  def test_suggest_returns_array_of_options_more_than_one_word
    completion = CompleteMe.new
    completion.insert("pizza")
    completion.insert("pizzeria")
    result = completion.suggest("piz")
    assert_equal ["pizza", "pizzeria"], result
  end

  def test_populate_returns_words_added
    completion = CompleteMe.new
    small_dictionary = "pizza\ndog\ncat"
    expected = ["pizza", "dog", "cat"]
    assert_equal expected, completion.populate(small_dictionary)
  end

  def test_populate_adds_whole_dictionary
    skip
    completion = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")

    completion.populate(dictionary)
    assert_equal 235886, completion.count

    result = completion.suggest("piz")
    assert_equal ["pize", "pizza", "pizzeria", "pizzicato", "pizzle"], result

    completion.select("piz", "pizzeria")
    result = completion.suggest("piz")
    assert_equal ["pizzeria", "pize", "pizza", "pizzicato", "pizzle"], result
    do_expected = ["do", "doab", "doable", "doarium", "doat", "doated", "doater", "doating", "doatish", "dob", "dobbed", "dobber", "dobbin", "dobbing", "dobby", "dobe", "dobla", "doblon", "dobra",
      "dobrao", "dobson", "doby", "doc", "docent", "docentship", "dochmiac", "dochmiacal", "dochmiasis", "dochmius", "docibility", "docible", "docibleness", "docile", "docilely", "docility", "docimasia", "docimastic", "docimastical", "docimasy",
      "docimology", "docity", "dock", "dockage", "docken", "docker", "docket", "dockhead", "dockhouse", "dockization", "dockize", "dockland", "dockmackie", "dockman", "dockmaster", "dockside", "dockyard", "dockyardman", "docmac", "docoglossan",
      "docoglossate", "docosane", "doctor", "doctoral", "doctorally", "doctorate", "doctorbird", "doctordom", "doctoress", "doctorfish", "doctorhood", "doctorial", "doctorially", "doctorization", "doctorize", "doctorless", "doctorlike", "doctorly", "doctorship", "doctress",
      "doctrinaire", "doctrinairism", "doctrinal", "doctrinalism", "doctrinalist", "doctrinality", "doctrinally", "doctrinarian", "doctrinarianism", "doctrinarily", "doctrinarity", "doctrinary", "doctrinate", "doctrine", "doctrinism", "doctrinist", "doctrinization", "doctrinize", "doctrix", "document",
      "documental", "documentalist", "documentarily", "documentary", "documentation", "documentize", "dod", "dodd", "doddart", "dodded", "dodder", "doddered", "dodderer", "doddering", "doddery", "doddie", "dodding", "doddle", "doddy", "doddypoll",
      "dodecade", "dodecadrachm", "dodecafid", "dodecagon", "dodecagonal", "dodecahedral", "dodecahedric", "dodecahedron", "dodecahydrate", "dodecahydrated", "dodecamerous", "dodecane", "dodecanoic", "dodecant", "dodecapartite", "dodecapetalous", "dodecarch", "dodecarchy", "dodecasemic", "dodecastyle",
      "dodecastylos", "dodecasyllabic", "dodecasyllable", "dodecatemory", "dodecatoic", "dodecatyl", "dodecatylic", "dodecuplet", "dodecyl", "dodecylene", "dodecylic", "dodge", "dodgeful", "dodger", "dodgery", "dodgily", "dodginess", "dodgy", "dodkin", "dodlet",
      "dodman", "dodo", "dodoism", "dodrans", "doe", "doebird", "doeglic", "doegling", "doer", "does", "doeskin", "doesnt", "doest", "doff", "doffer", "doftberry", "dog", "dogal", "dogate", "dogbane",
      "dogberry", "dogbite", "dogblow", "dogboat", "dogbolt", "dogbush", "dogcart", "dogcatcher", "dogdom", "doge", "dogedom", "dogeless", "dogeship", "dogface", "dogfall", "dogfight", "dogfish", "dogfoot", "dogged", "doggedly",
      "doggedness", "dogger", "doggerel", "doggereler", "doggerelism", "doggerelist", "doggerelize", "doggerelizer", "doggery", "doggess", "doggish", "doggishly", "doggishness", "doggo", "doggone", "doggoned", "doggrel", "doggrelize", "doggy", "doghead",
      "doghearted", "doghole", "doghood", "doghouse", "dogie", "dogless", "doglike", "dogly", "dogma", "dogman", "dogmata", "dogmatic", "dogmatical", "dogmatically", "dogmaticalness", "dogmatician", "dogmatics", "dogmatism", "dogmatist", "dogmatization",
      "dogmatize", "dogmatizer", "dogmouth", "dogplate", "dogproof", "dogs", "dogship", "dogshore", "dogskin", "dogsleep", "dogstone", "dogtail", "dogtie", "dogtooth", "dogtoothing", "dogtrick", "dogtrot", "dogvane", "dogwatch", "dogwood",
      "dogy", "doigt", "doiled", "doily", "doina", "doing", "doings", "doit", "doited", "doitkin", "doitrified", "doke", "dokhma", "dokimastic", "dola", "dolabra", "dolabrate", "dolabriform", "dolcan", "dolcian",
      "dolciano", "dolcino", "doldrum", "doldrums", "dole", "dolefish", "doleful", "dolefully", "dolefulness", "dolefuls", "dolent", "dolently", "dolerite", "doleritic", "dolerophanite", "dolesman", "dolesome", "dolesomely", "dolesomeness", "doless",
      "doli", "dolia", "dolichoblond", "dolichocephal", "dolichocephali", "dolichocephalic", "dolichocephalism", "dolichocephalize", "dolichocephalous", "dolichocephaly", "dolichocercic", "dolichocnemic", "dolichocranial", "dolichofacial", "dolichohieric", "dolichopellic", "dolichopodous", "dolichoprosopic", "dolichos", "dolichosaur",
      "dolichostylous", "dolichotmema", "dolichuric", "dolichurus", "dolina", "doline", "dolioform", "dolium", "doll", "dollar", "dollarbird", "dollardee", "dollardom", "dollarfish", "dollarleaf", "dollbeer", "dolldom", "dollface", "dollfish", "dollhood",
      "dollhouse", "dollier", "dolliness", "dollish", "dollishly", "dollishness", "dollmaker", "dollmaking", "dollop", "dollship", "dolly", "dollyman", "dollyway", "dolman", "dolmen", "dolmenic", "dolomite", "dolomitic", "dolomitization", "dolomitize",
      "dolomization", "dolomize", "dolor", "doloriferous", "dolorific", "dolorifuge", "dolorous", "dolorously", "dolorousness", "dolose", "dolous", "dolphin", "dolphinlike", "dolt", "dolthead", "doltish", "doltishly", "doltishness", "dom", "domain",
      "domainal", "domal", "domanial", "domatium", "domatophobia", "domba", "dome", "domelike", "doment", "domer", "domesday", "domestic", "domesticable", "domesticality", "domestically", "domesticate", "domestication", "domesticative", "domesticator", "domesticity",
      "domesticize", "domett", "domeykite", "domic", "domical", "domically", "domicile", "domicilement", "domiciliar", "domiciliary", "domiciliate", "domiciliation", "dominance", "dominancy", "dominant", "dominantly", "dominate", "dominated", "dominatingly", "domination",
      "dominative", "dominator", "domine", "domineer", "domineerer", "domineering", "domineeringly", "domineeringness", "dominial", "dominical", "dominicale", "dominie", "dominion", "dominionism", "dominionist", "dominium", "domino", "dominus", "domitable", "domite",
      "domitic", "domn", "domnei", "domoid", "dompt", "domy", "don", "donable", "donaciform", "donary", "donatary", "donate", "donated", "donatee", "donation", "donative", "donatively", "donator", "donatory", "donatress",
      "donax", "doncella", "done", "donee", "doney", "dong", "donga", "dongon", "donjon", "donkey", "donkeyback", "donkeyish", "donkeyism", "donkeyman", "donkeywork", "donna", "donnered", "donnert", "donnish", "donnishness",
      "donnism", "donnot", "donor", "donorship", "donought", "donship", "donsie", "dont", "donum", "doob", "doocot", "doodab", "doodad", "doodle", "doodlebug", "doodler", "doodlesack", "doohickey", "doohickus", "doohinkey",
      "doohinkus", "dooja", "dook", "dooket", "dookit", "dool", "doolee", "dooley", "dooli", "doolie", "dooly", "doom", "doomage", "doombook", "doomer", "doomful", "dooms", "doomsday", "doomsman", "doomstead",
      "doon", "door", "doorba", "doorbell", "doorboy", "doorbrand", "doorcase", "doorcheek", "doored", "doorframe", "doorhead", "doorjamb", "doorkeeper", "doorknob", "doorless", "doorlike", "doormaid", "doormaker", "doormaking", "doorman",
      "doornail", "doorplate", "doorpost", "doorsill", "doorstead", "doorstep", "doorstone", "doorstop", "doorward", "doorway", "doorweed", "doorwise", "dooryard", "dop", "dopa", "dopamelanin", "dopaoxidase", "dopatta", "dope", "dopebook",
      "doper", "dopester", "dopey", "doppelkummel", "dopper", "doppia", "dopplerite", "dor", "dorab", "dorad", "dorado", "doraphobia", "dorbeetle", "dorcastry", "doree", "dorestane", "dorhawk", "doria", "dorje", "dorlach",
      "dorlot", "dorm", "dormancy", "dormant", "dormer", "dormered", "dormie", "dormient", "dormilona", "dormition", "dormitive", "dormitory", "dormouse", "dormy", "dorn", "dorneck", "dornic", "dornick", "dornock", "dorp",
      "dorsabdominal", "dorsabdominally", "dorsad", "dorsal", "dorsale", "dorsalgia", "dorsalis", "dorsally", "dorsalmost", "dorsalward", "dorsalwards", "dorsel", "dorser", "dorsibranch", "dorsibranchiate", "dorsicollar", "dorsicolumn", "dorsicommissure", "dorsicornu", "dorsiduct",
      "dorsiferous", "dorsifixed", "dorsiflex", "dorsiflexion", "dorsiflexor", "dorsigrade", "dorsilateral", "dorsilumbar", "dorsimedian", "dorsimesal", "dorsimeson", "dorsiparous", "dorsispinal", "dorsiventral", "dorsiventrality", "dorsiventrally", "dorsoabdominal", "dorsoanterior", "dorsoapical", "dorsocaudad",
      "dorsocaudal", "dorsocentral", "dorsocephalad", "dorsocephalic", "dorsocervical", "dorsocervically", "dorsodynia", "dorsoepitrochlear", "dorsointercostal", "dorsointestinal", "dorsolateral", "dorsolumbar", "dorsomedial", "dorsomedian", "dorsomesal", "dorsonasal", "dorsonuchal", "dorsopleural", "dorsoposteriad", "dorsoposterior",
      "dorsoradial", "dorsosacral", "dorsoscapular", "dorsosternal", "dorsothoracic", "dorsoventrad", "dorsoventral", "dorsoventrally", "dorsulum", "dorsum", "dorsumbonal", "dorter", "dortiness", "dortiship", "dorts", "dorty", "doruck", "dory", "doryphorus", "dos",
      "dosa", "dosadh", "dosage", "dose", "doser", "dosimeter", "dosimetric", "dosimetrician", "dosimetrist", "dosimetry", "dosiology", "dosis", "dosology", "doss", "dossal", "dossel", "dosser", "dosseret", "dossier", "dossil",
      "dossman", "dot", "dotage", "dotal", "dotard", "dotardism", "dotardly", "dotardy", "dotate", "dotation", "dotchin", "dote", "doted", "doter", "dothideaceous", "dothienenteritis", "dotiness", "doting", "dotingly", "dotingness",
      "dotish", "dotishness", "dotkin", "dotless", "dotlike", "dotriacontane", "dotted", "dotter", "dotterel", "dottily", "dottiness", "dotting", "dottle", "dottler", "dotty", "doty", "douar", "double", "doubled", "doubledamn",
      "doubleganger", "doublegear", "doublehanded", "doublehandedly", "doublehandedness", "doublehatching", "doublehearted", "doubleheartedness", "doublehorned", "doubleleaf", "doublelunged", "doubleness", "doubler", "doublet", "doubleted", "doubleton", "doubletone", "doubletree", "doublets", "doubling",
      "doubloon", "doubly", "doubt", "doubtable", "doubtably", "doubtedly", "doubter", "doubtful", "doubtfully", "doubtfulness", "doubting", "doubtingly", "doubtingness", "doubtless", "doubtlessly", "doubtlessness", "doubtmonger", "doubtous", "doubtsome", "douc",
      "douce", "doucely", "douceness", "doucet", "douche", "doucin", "doucine", "doudle", "dough", "doughbird", "doughboy", "doughface", "doughfaceism", "doughfoot", "doughhead", "doughiness", "doughlike", "doughmaker", "doughmaking", "doughman",
      "doughnut", "dought", "doughtily", "doughtiness", "doughty", "doughy", "doulocracy", "doum", "doundake", "doup", "douping", "dour", "dourine", "dourly", "dourness", "douse", "douser", "dout", "douter", "doutous",
      "douzepers", "douzieme", "dove", "dovecot", "doveflower", "dovefoot", "dovehouse", "dovekey", "dovekie", "dovelet", "dovelike", "doveling", "dover", "dovetail", "dovetailed", "dovetailer", "dovetailwise", "doveweed", "dovewood", "dovish",
      "dow", "dowable", "dowager", "dowagerism", "dowcet", "dowd", "dowdily", "dowdiness", "dowdy", "dowdyish", "dowdyism", "dowed", "dowel", "dower", "doweral", "doweress", "dowerless", "dowery", "dowf", "dowie",
      "dowily", "dowiness", "dowitch", "dowitcher", "dowl", "dowlas", "dowless", "down", "downbear", "downbeard", "downbeat", "downby", "downcast", "downcastly", "downcastness", "downcome", "downcomer", "downcoming", "downcry", "downcurved",
      "downcut", "downdale", "downdraft", "downer", "downface", "downfall", "downfallen", "downfalling", "downfeed", "downflow", "downfold", "downfolded", "downgate", "downgone", "downgrade", "downgrowth", "downhanging", "downhaul", "downheaded", "downhearted",
      "downheartedly", "downheartedness", "downhill", "downily", "downiness", "downland", "downless", "downlie", "downlier", "downligging", "downlike", "downline", "downlooked", "downlooker", "downlying", "downmost", "downness", "downpour", "downpouring", "downright",
      "downrightly", "downrightness", "downrush", "downrushing", "downset", "downshare", "downshore", "downside", "downsinking", "downsitting", "downsliding", "downslip", "downslope", "downsman", "downspout", "downstage", "downstairs", "downstate", "downstater", "downstream",
      "downstreet", "downstroke", "downswing", "downtake", "downthrow", "downthrown", "downthrust", "downtown", "downtrampling", "downtreading", "downtrend", "downtrodden", "downtroddenness", "downturn", "downward", "downwardly", "downwardness", "downway", "downweed", "downweigh",
      "downweight", "downweighted", "downwind", "downwith", "downy", "dowp", "dowry", "dowsabel", "dowse", "dowser", "dowset", "doxa", "doxastic", "doxasticon", "doxographer", "doxographical", "doxography", "doxological", "doxologically", "doxologize",
      "doxology", "doxy", "doze", "dozed", "dozen", "dozener", "dozenth", "dozer", "dozily", "doziness", "dozy", "dozzled"]
    assert_equal do_expected, completion.suggest("do")
    completion.select("do", "doggedly")
    do_expected_with_weight = ["doggedly", "do", "doab", "doable", "doarium", "doat", "doated", "doater", "doating", "doatish", "dob", "dobbed", "dobber", "dobbin", "dobbing", "dobby", "dobe", "dobla", "doblon", "dobra",
      "dobrao", "dobson", "doby", "doc", "docent", "docentship", "dochmiac", "dochmiacal", "dochmiasis", "dochmius", "docibility", "docible", "docibleness", "docile", "docilely", "docility", "docimasia", "docimastic", "docimastical", "docimasy",
      "docimology", "docity", "dock", "dockage", "docken", "docker", "docket", "dockhead", "dockhouse", "dockization", "dockize", "dockland", "dockmackie", "dockman", "dockmaster", "dockside", "dockyard", "dockyardman", "docmac", "docoglossan",
      "docoglossate", "docosane", "doctor", "doctoral", "doctorally", "doctorate", "doctorbird", "doctordom", "doctoress", "doctorfish", "doctorhood", "doctorial", "doctorially", "doctorization", "doctorize", "doctorless", "doctorlike", "doctorly", "doctorship", "doctress",
      "doctrinaire", "doctrinairism", "doctrinal", "doctrinalism", "doctrinalist", "doctrinality", "doctrinally", "doctrinarian", "doctrinarianism", "doctrinarily", "doctrinarity", "doctrinary", "doctrinate", "doctrine", "doctrinism", "doctrinist", "doctrinization", "doctrinize", "doctrix", "document",
      "documental", "documentalist", "documentarily", "documentary", "documentation", "documentize", "dod", "dodd", "doddart", "dodded", "dodder", "doddered", "dodderer", "doddering", "doddery", "doddie", "dodding", "doddle", "doddy", "doddypoll",
      "dodecade", "dodecadrachm", "dodecafid", "dodecagon", "dodecagonal", "dodecahedral", "dodecahedric", "dodecahedron", "dodecahydrate", "dodecahydrated", "dodecamerous", "dodecane", "dodecanoic", "dodecant", "dodecapartite", "dodecapetalous", "dodecarch", "dodecarchy", "dodecasemic", "dodecastyle",
      "dodecastylos", "dodecasyllabic", "dodecasyllable", "dodecatemory", "dodecatoic", "dodecatyl", "dodecatylic", "dodecuplet", "dodecyl", "dodecylene", "dodecylic", "dodge", "dodgeful", "dodger", "dodgery", "dodgily", "dodginess", "dodgy", "dodkin", "dodlet",
      "dodman", "dodo", "dodoism", "dodrans", "doe", "doebird", "doeglic", "doegling", "doer", "does", "doeskin", "doesnt", "doest", "doff", "doffer", "doftberry", "dog", "dogal", "dogate", "dogbane",
      "dogberry", "dogbite", "dogblow", "dogboat", "dogbolt", "dogbush", "dogcart", "dogcatcher", "dogdom", "doge", "dogedom", "dogeless", "dogeship", "dogface", "dogfall", "dogfight", "dogfish", "dogfoot", "dogged",
      "doggedness", "dogger", "doggerel", "doggereler", "doggerelism", "doggerelist", "doggerelize", "doggerelizer", "doggery", "doggess", "doggish", "doggishly", "doggishness", "doggo", "doggone", "doggoned", "doggrel", "doggrelize", "doggy", "doghead",
      "doghearted", "doghole", "doghood", "doghouse", "dogie", "dogless", "doglike", "dogly", "dogma", "dogman", "dogmata", "dogmatic", "dogmatical", "dogmatically", "dogmaticalness", "dogmatician", "dogmatics", "dogmatism", "dogmatist", "dogmatization",
      "dogmatize", "dogmatizer", "dogmouth", "dogplate", "dogproof", "dogs", "dogship", "dogshore", "dogskin", "dogsleep", "dogstone", "dogtail", "dogtie", "dogtooth", "dogtoothing", "dogtrick", "dogtrot", "dogvane", "dogwatch", "dogwood",
      "dogy", "doigt", "doiled", "doily", "doina", "doing", "doings", "doit", "doited", "doitkin", "doitrified", "doke", "dokhma", "dokimastic", "dola", "dolabra", "dolabrate", "dolabriform", "dolcan", "dolcian",
      "dolciano", "dolcino", "doldrum", "doldrums", "dole", "dolefish", "doleful", "dolefully", "dolefulness", "dolefuls", "dolent", "dolently", "dolerite", "doleritic", "dolerophanite", "dolesman", "dolesome", "dolesomely", "dolesomeness", "doless",
      "doli", "dolia", "dolichoblond", "dolichocephal", "dolichocephali", "dolichocephalic", "dolichocephalism", "dolichocephalize", "dolichocephalous", "dolichocephaly", "dolichocercic", "dolichocnemic", "dolichocranial", "dolichofacial", "dolichohieric", "dolichopellic", "dolichopodous", "dolichoprosopic", "dolichos", "dolichosaur",
      "dolichostylous", "dolichotmema", "dolichuric", "dolichurus", "dolina", "doline", "dolioform", "dolium", "doll", "dollar", "dollarbird", "dollardee", "dollardom", "dollarfish", "dollarleaf", "dollbeer", "dolldom", "dollface", "dollfish", "dollhood",
      "dollhouse", "dollier", "dolliness", "dollish", "dollishly", "dollishness", "dollmaker", "dollmaking", "dollop", "dollship", "dolly", "dollyman", "dollyway", "dolman", "dolmen", "dolmenic", "dolomite", "dolomitic", "dolomitization", "dolomitize",
      "dolomization", "dolomize", "dolor", "doloriferous", "dolorific", "dolorifuge", "dolorous", "dolorously", "dolorousness", "dolose", "dolous", "dolphin", "dolphinlike", "dolt", "dolthead", "doltish", "doltishly", "doltishness", "dom", "domain",
      "domainal", "domal", "domanial", "domatium", "domatophobia", "domba", "dome", "domelike", "doment", "domer", "domesday", "domestic", "domesticable", "domesticality", "domestically", "domesticate", "domestication", "domesticative", "domesticator", "domesticity",
      "domesticize", "domett", "domeykite", "domic", "domical", "domically", "domicile", "domicilement", "domiciliar", "domiciliary", "domiciliate", "domiciliation", "dominance", "dominancy", "dominant", "dominantly", "dominate", "dominated", "dominatingly", "domination",
      "dominative", "dominator", "domine", "domineer", "domineerer", "domineering", "domineeringly", "domineeringness", "dominial", "dominical", "dominicale", "dominie", "dominion", "dominionism", "dominionist", "dominium", "domino", "dominus", "domitable", "domite",
      "domitic", "domn", "domnei", "domoid", "dompt", "domy", "don", "donable", "donaciform", "donary", "donatary", "donate", "donated", "donatee", "donation", "donative", "donatively", "donator", "donatory", "donatress",
      "donax", "doncella", "done", "donee", "doney", "dong", "donga", "dongon", "donjon", "donkey", "donkeyback", "donkeyish", "donkeyism", "donkeyman", "donkeywork", "donna", "donnered", "donnert", "donnish", "donnishness",
      "donnism", "donnot", "donor", "donorship", "donought", "donship", "donsie", "dont", "donum", "doob", "doocot", "doodab", "doodad", "doodle", "doodlebug", "doodler", "doodlesack", "doohickey", "doohickus", "doohinkey",
      "doohinkus", "dooja", "dook", "dooket", "dookit", "dool", "doolee", "dooley", "dooli", "doolie", "dooly", "doom", "doomage", "doombook", "doomer", "doomful", "dooms", "doomsday", "doomsman", "doomstead",
      "doon", "door", "doorba", "doorbell", "doorboy", "doorbrand", "doorcase", "doorcheek", "doored", "doorframe", "doorhead", "doorjamb", "doorkeeper", "doorknob", "doorless", "doorlike", "doormaid", "doormaker", "doormaking", "doorman",
      "doornail", "doorplate", "doorpost", "doorsill", "doorstead", "doorstep", "doorstone", "doorstop", "doorward", "doorway", "doorweed", "doorwise", "dooryard", "dop", "dopa", "dopamelanin", "dopaoxidase", "dopatta", "dope", "dopebook",
      "doper", "dopester", "dopey", "doppelkummel", "dopper", "doppia", "dopplerite", "dor", "dorab", "dorad", "dorado", "doraphobia", "dorbeetle", "dorcastry", "doree", "dorestane", "dorhawk", "doria", "dorje", "dorlach",
      "dorlot", "dorm", "dormancy", "dormant", "dormer", "dormered", "dormie", "dormient", "dormilona", "dormition", "dormitive", "dormitory", "dormouse", "dormy", "dorn", "dorneck", "dornic", "dornick", "dornock", "dorp",
      "dorsabdominal", "dorsabdominally", "dorsad", "dorsal", "dorsale", "dorsalgia", "dorsalis", "dorsally", "dorsalmost", "dorsalward", "dorsalwards", "dorsel", "dorser", "dorsibranch", "dorsibranchiate", "dorsicollar", "dorsicolumn", "dorsicommissure", "dorsicornu", "dorsiduct",
      "dorsiferous", "dorsifixed", "dorsiflex", "dorsiflexion", "dorsiflexor", "dorsigrade", "dorsilateral", "dorsilumbar", "dorsimedian", "dorsimesal", "dorsimeson", "dorsiparous", "dorsispinal", "dorsiventral", "dorsiventrality", "dorsiventrally", "dorsoabdominal", "dorsoanterior", "dorsoapical", "dorsocaudad",
      "dorsocaudal", "dorsocentral", "dorsocephalad", "dorsocephalic", "dorsocervical", "dorsocervically", "dorsodynia", "dorsoepitrochlear", "dorsointercostal", "dorsointestinal", "dorsolateral", "dorsolumbar", "dorsomedial", "dorsomedian", "dorsomesal", "dorsonasal", "dorsonuchal", "dorsopleural", "dorsoposteriad", "dorsoposterior",
      "dorsoradial", "dorsosacral", "dorsoscapular", "dorsosternal", "dorsothoracic", "dorsoventrad", "dorsoventral", "dorsoventrally", "dorsulum", "dorsum", "dorsumbonal", "dorter", "dortiness", "dortiship", "dorts", "dorty", "doruck", "dory", "doryphorus", "dos",
      "dosa", "dosadh", "dosage", "dose", "doser", "dosimeter", "dosimetric", "dosimetrician", "dosimetrist", "dosimetry", "dosiology", "dosis", "dosology", "doss", "dossal", "dossel", "dosser", "dosseret", "dossier", "dossil",
      "dossman", "dot", "dotage", "dotal", "dotard", "dotardism", "dotardly", "dotardy", "dotate", "dotation", "dotchin", "dote", "doted", "doter", "dothideaceous", "dothienenteritis", "dotiness", "doting", "dotingly", "dotingness",
      "dotish", "dotishness", "dotkin", "dotless", "dotlike", "dotriacontane", "dotted", "dotter", "dotterel", "dottily", "dottiness", "dotting", "dottle", "dottler", "dotty", "doty", "douar", "double", "doubled", "doubledamn",
      "doubleganger", "doublegear", "doublehanded", "doublehandedly", "doublehandedness", "doublehatching", "doublehearted", "doubleheartedness", "doublehorned", "doubleleaf", "doublelunged", "doubleness", "doubler", "doublet", "doubleted", "doubleton", "doubletone", "doubletree", "doublets", "doubling",
      "doubloon", "doubly", "doubt", "doubtable", "doubtably", "doubtedly", "doubter", "doubtful", "doubtfully", "doubtfulness", "doubting", "doubtingly", "doubtingness", "doubtless", "doubtlessly", "doubtlessness", "doubtmonger", "doubtous", "doubtsome", "douc",
      "douce", "doucely", "douceness", "doucet", "douche", "doucin", "doucine", "doudle", "dough", "doughbird", "doughboy", "doughface", "doughfaceism", "doughfoot", "doughhead", "doughiness", "doughlike", "doughmaker", "doughmaking", "doughman",
      "doughnut", "dought", "doughtily", "doughtiness", "doughty", "doughy", "doulocracy", "doum", "doundake", "doup", "douping", "dour", "dourine", "dourly", "dourness", "douse", "douser", "dout", "douter", "doutous",
      "douzepers", "douzieme", "dove", "dovecot", "doveflower", "dovefoot", "dovehouse", "dovekey", "dovekie", "dovelet", "dovelike", "doveling", "dover", "dovetail", "dovetailed", "dovetailer", "dovetailwise", "doveweed", "dovewood", "dovish",
      "dow", "dowable", "dowager", "dowagerism", "dowcet", "dowd", "dowdily", "dowdiness", "dowdy", "dowdyish", "dowdyism", "dowed", "dowel", "dower", "doweral", "doweress", "dowerless", "dowery", "dowf", "dowie",
      "dowily", "dowiness", "dowitch", "dowitcher", "dowl", "dowlas", "dowless", "down", "downbear", "downbeard", "downbeat", "downby", "downcast", "downcastly", "downcastness", "downcome", "downcomer", "downcoming", "downcry", "downcurved",
      "downcut", "downdale", "downdraft", "downer", "downface", "downfall", "downfallen", "downfalling", "downfeed", "downflow", "downfold", "downfolded", "downgate", "downgone", "downgrade", "downgrowth", "downhanging", "downhaul", "downheaded", "downhearted",
      "downheartedly", "downheartedness", "downhill", "downily", "downiness", "downland", "downless", "downlie", "downlier", "downligging", "downlike", "downline", "downlooked", "downlooker", "downlying", "downmost", "downness", "downpour", "downpouring", "downright",
      "downrightly", "downrightness", "downrush", "downrushing", "downset", "downshare", "downshore", "downside", "downsinking", "downsitting", "downsliding", "downslip", "downslope", "downsman", "downspout", "downstage", "downstairs", "downstate", "downstater", "downstream",
      "downstreet", "downstroke", "downswing", "downtake", "downthrow", "downthrown", "downthrust", "downtown", "downtrampling", "downtreading", "downtrend", "downtrodden", "downtroddenness", "downturn", "downward", "downwardly", "downwardness", "downway", "downweed", "downweigh",
      "downweight", "downweighted", "downwind", "downwith", "downy", "dowp", "dowry", "dowsabel", "dowse", "dowser", "dowset", "doxa", "doxastic", "doxasticon", "doxographer", "doxographical", "doxography", "doxological", "doxologically", "doxologize",
      "doxology", "doxy", "doze", "dozed", "dozen", "dozener", "dozenth", "dozer", "dozily", "doziness", "dozy", "dozzled"]
    assert_equal do_expected_with_weight, completion.suggest("do")

  end

  def test_completeme_select_changes_suggest_output
    # skip
    completion = CompleteMe.new

    completion.insert("pizza")
    completion.insert("pizzeria")
    completion.insert("pize")
    completion.insert("pizzaro")

    completion.select("piz", "pizzeria")
    assert_equal ["pizzeria", "pize", "pizza", "pizzaro"], completion.suggest("piz")

    completion.select("piz", "pizzeria")
    completion.select("piz", "pizza")

    assert_equal ["pizzeria", "pizza", "pize", "pizzaro"], completion.suggest("piz")

    completion.select("pi", "pize")
    completion.select("pi", "pize")
    completion.select("pi", "pizza")

    assert_equal ["pize", "pizza", "pizzaro", "pizzeria"], completion.suggest("pi")

    completion.insert("do")
    completion.insert("dog")
    completion.insert("dogged")
    completion.insert("doggedly")

    assert_equal ["do", "dog", "dogged", "doggedly"], completion.suggest("do")

  end

  def test_delete_removes_word
    completion = CompleteMe.new
    completion.insert("piza")
    assert_equal 1, completion.count
    assert_equal ["piza"], completion.suggest("piz")

    completion.delete("piza")
    assert_equal 0, completion.count
    assert_equal "No Suggestions", completion.suggest("piz")

  end

end
