# frozen_string_literal: true

# Simple pluralize functionality to handle mile > miles.
# For a production application, I'd use ActiveSupport::Inflector.pluralize
def pluralize(count, word)
  return "#{count} #{word}" if count == 1

  "#{count} #{word}s"
end
