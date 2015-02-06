#!/usr/bin/ruby

require 'json'

class Array
	def random_element
		self[rand(self.count)]
	end
end

class String
	def up_first
		self[0].upcase + self[1..-1]
	end
end

$bits = {
    "adjective_good" => [
        "brave",
        "kind",
        "nice",
        "good",
        "wealthy",
        "happy",
        "free",
        "special",
        "intelligent",
        "clever",
        "lovely",
        "peaceful"
    ],
    "cheat" => [
        "cheated",
        "tricked"
    ],
    "conflict" => [
        "kidnap",
        "witch",
        "destroy"
    ],
    "conflict_end" => [
        "flee",
        "kill",
        "imprison"
    ],
    "destroy" => [
        "destroy",
        "ruined",
        "wrecked",
        "smashed",
        "demolished"
    ],
    "destroyobject" => [
        "house",
        "garden",
        "doghouse",
        "temple",
        "clock",
        "field",
        "farm",
        "tower",
        "building",
        "residence",
        "domicile",
        "place of birth",
        "home",
        "hovel",
        "hut",
        "flat",
        "flatlet"
    ],
    "entwitch" => [
        "freed",
        "ended the spell cast on",
        "ended the enchantment of"
    ],
    "flee" => [
        "fled",
        "fled in terror",
        "escaped"
    ],
    "imprison" => [
        "imprisoned",
        "arrested",
        "jailed"
    ],
    "kidnap" => [
        "kidnapped",
        "abducted",
        "carried off"
    ],
    "kill" => [
        "killed",
        "murdered",
        "slew",
        "assassinated"
    ],
    "onceupon" => [
        "Once Upon a Time",
        "In a land far away",
        "Before you were born",
        "In a little village"
    ],
    "oneday" => [
        "One day",
        "There came a day",
        "One night"
    ],
    "person_evil" => [
        "warlock",
        "necromancer",
        "ghost",
        "demon",
        "goblin",
        "troll",
        "monster",
        "dwarf",
        "giant",
        "barbarian",
        "grook",
        "rogue",
        "bandit",
        "rascal",
        "scoundrel",
        "orc",
        "ogre",
        "soldier",
        "warrior",
        "fighter",
        "viking",
        "mage",
        "villain",
        "archer",
        "phantom"
    ],
    "person_good" => [
        "trader",
        "merchant",
        "salesperson",
        "peasant",
        "farmer",
        "hero",
        "blacksmith",
        "artist",
        "poet"
    ],
    "relative" => [
        "dog",
        "cat",
        "mother",
        "father",
        "grandfather",
        "grandmother",
        "brother",
        "son",
        "sister",
        "daughter",
        "friend",
        "mate"
    ],
    "then" => [
        "Then",
        "Finally",
        "Ultimately",
        "In the end",
        "Thereupon",
        "Thereat",
        "After that"
    ],
    "witch" => [
        "enchanted",
        "spellbound",
        "bewitched",
        "entranced"
    ]
}

def random_word(category)
	$bits[category].random_element
end

def articleize(word)
	if word =~ /^[aeiou]/i then 'an ' else 'a ' end + word
end

def narrate
	strplot = []
	confl = random_word('conflict')
	if confl == 'kidnap' || confl == 'destroy' then
		strplot << confl
		if rand(2) == 1 then
			strplot << 'cheat'
		end
	end
	if confl == 'witch' then
		strplot << confl
		strplot << 'cheat'
		strplot << 'entwitch'
	end

	strplot << random_word('conflict_end')

	pnames = []
	pgender = []

	pnames << random_word('person_good')
	pnames << random_word('person_evil')
	0.upto(1).each do |i|
		pgender << if rand(2) == 1 then 'he' else 'she' end
	end

	protag_adj = random_word('adjective_good')

	story = []
	if rand(2) == 1 then
		story << random_word('onceupon') + ' there lived ' + articleize(pnames[0]) + '.'
	else
		story << random_word('onceupon') + ' there lived ' + articleize(protag_adj) + ' ' + pnames[0] + '.'
	end

	strplot.each do |subplot|
		case subplot
		when 'kidnap'
			if rand(2) == 1 then
				story << random_word('oneday') + ' ' + pgender[0] + ' was ' + random_word('kidnap') + ' by ' + articleize(pnames[1]) + '.'
			else
				story << 'One day the ' + pnames[0] + ' was ' + random_word('kidnap') + ' by ' + articleize(pnames[1]) + '.'
			end
		when 'destroy'
			if rand(2) == 1 then
				story << random_word('oneday') + ' ' + articleize(pnames[1]) + ' ' + random_word('destroy') + ' the ' + random_word('destroyobject') + ' of the ' + pnames[0] + '.'
			else
				story << 'One day ' + articleize(pnames[1]) + ' ' + random_word('kill') + ' the ' + random_word('relative') + ' of the ' + pnames[0] + '.'
			end
		when 'cheat'
			if rand(2) == 1 then
				story << pgender[0].up_first + ' ' + random_word('cheat') + ' the ' + pnames[1] + '.'
			else
				story << 'The ' + pnames[0] + ' ' + random_word('cheat') + ' the ' + pnames[1] + '.'
			end
		when 'kill'
			if rand(2) == 1 then
				story << random_word('then') + ' ' + pgender[0] + ' ' + random_word('kill') + ' the ' + pnames[1] + '.'
			else
				story << 'Then the ' + pnames[0] + ' ' + random_word('kill') + ' the ' + pnames[1] + '.'
			end
		when 'flee'
			if rand(2) == 1 then
				story << random_word('then') + ' ' + pgender[0] + ' ' + random_word('flee') + '.'
			else
				story << 'Then the ' + pnames[0] + ' ' + random_word('flee') + '.'
			end
		when 'witch' then
			if rand(2) == 1 then
				story << random_word('oneday') + ' ' + pgender[0] + ' was ' + random_word('witch') + ' by ' + articleize(pnames[1]) + '.'
			else
				story << 'One day the ' + pnames[0] + ' was ' + random_word('witch') + ' by ' + articleize(pnames[1]) + '.'
			end
		when 'entwitch' then
			story << 'The ' + pnames[1] + ' ' + random_word('entwitch') + ' the ' + pnames[0] + '.'
		when 'imprison' then
			if rand(2) == 1 then
				story << random_word('then') + ' ' + pgender[0] + ' ' + random_word('imprison') + ' the ' + pnames[1] + '.'
			else
				story << 'Then the ' + pnames[0] + ' ' + random_word('imprison') + ' the ' + pnames[1] + '.'
			end
		end
	end

	case rand(3)
	when 0
		title = 'The ' + pnames[1].up_first
	when 1
		title = 'The ' + pnames[0].up_first + ' and The ' + pnames[1].up_first
	when 2
		title = 'The ' + protag_adj.up_first + ' ' + pnames[0].up_first
	end
	# Create a new file and write to it  
File.open("5000_stories.txt", 'a') do |f2|
  f2.puts "______________________________________________________\n\n#{title}\n\n"  
  story.each do |line|
  f2.puts (line)
  end 
end  
end
narrate()
