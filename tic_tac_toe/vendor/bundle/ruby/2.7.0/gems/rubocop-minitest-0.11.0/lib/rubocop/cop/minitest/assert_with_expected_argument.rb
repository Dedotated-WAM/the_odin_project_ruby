# frozen_string_literal: true

module RuboCop
  module Cop
    module Minitest
      # This cop tries to detect when a user accidentally used
      # `assert` when they meant to use `assert_equal`.
      #
      # @example
      #   # bad
      #   assert(3, my_list.length)
      #   assert(expected, actual)
      #
      #   # good
      #   assert_equal(3, my_list.length)
      #   assert_equal(expected, actual)
      #   assert(foo, 'message')
      #
      class AssertWithExpectedArgument < Cop
        MSG = 'Did you mean to use `assert_equal(%<arguments>s)`?'
        RESTRICT_ON_SEND = %i[assert].freeze

        def_node_matcher :assert_with_two_arguments?, <<~PATTERN
          (send nil? :assert $_ $_)
        PATTERN

        def on_send(node)
          assert_with_two_arguments?(node) do |_expected, message|
            return if message.str_type? || message.dstr_type?

            arguments = node.arguments.map(&:source).join(', ')
            add_offense(node, message: format(MSG, arguments: arguments))
          end
        end
      end
    end
  end
end
