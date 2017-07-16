class Analyzer
	attr_accessor :lines, :text, :sentence_count, :paragraph_count, :stopwords, :word_count , 					 

	def initialize
		@lines = File.readlines(ARGV[0])
		@text = @lines.join
	end

	def line_counter
		line_count = @lines.size
		puts "#{line_count} lines"
	end

	def word_counter
		@word_count = @text.split.length
		puts "#{@word_count} words"
	end

	def character_counter
		character_count = @text.length
		puts "#{character_count} characters"
	end

	def character_counter_nospaces
		character_count_nospaces = @text.gsub(/\s+/, '').length
		puts "#{character_count_nospaces} characters excluding spaces"
	end

	def paragraph_counter
		@paragraph_count = @text.split(/\n\n/).length
		puts "#{@paragraph_count} paragraphs"
	end
  
  def sentence_counter
  	@sentence_count = @text.split(/\.|\?|!/).length
  	puts "#{@sentence_count} sentences"
  end

  def sentences_per_paragraph
			puts "#{@sentence_count / @paragraph_count} sentences per paragraph (average)"
	end

	def words_per_sentence
			puts "#{@word_count / @sentence_count} words per sentence (average)"
	end

	def good_words
		@stopwords = ["the", "a", "by", "on", "for", "of", "are", "with", "just", "but", "and", "to", "the", "my", "I"," has", "some", "in",]
		all_words = @text.scan(/\w+/)
		good_words = all_words.reject{ |word| @stopwords.include?(word) }
		good_percentage = ((good_words.length.to_f / all_words.length.to_f) * 100).to_i
		puts "#{good_percentage}% of words are non-fluff words"
	end

	def summary
		sentences = @text.gsub(/\s+/, ' ').strip.split(/\.|\?|!/)
		sentences_sorted = sentences.sort_by { |sentence| sentence.length }
		one_third = sentences_sorted.length / 3
		ideal_sentences = sentences_sorted.slice(one_third, one_third + 1)
		ideal_sentences = ideal_sentences.select { |sentence| sentence =~ /is|are/ }
		puts "Summary:\n\n" + ideal_sentences.join(". ")
	end
		

	def full_analysis
		line_counter
		word_counter
		character_counter
		character_counter_nospaces
		paragraph_counter
		sentence_counter
		sentences_per_paragraph
		words_per_sentence
		good_words
		summary
		puts "-- End of analysis"
	end
end

output = Analyzer.new

output.full_analysis
