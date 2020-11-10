module Kramdown
  module Converter
    class SheepHtml < Html
      def convert_codespan(el, indent)
        if not el.attr['dir']
          # Add dir="ltr" to the element
          el.attr['dir'] = 'ltr'
        end

        # Do whatever magic kramdown does
        super(el, indent)
      end

      def convert_codeblock(el, indent)
        if not el.attr['dir']
          # Add dir="ltr" to the element
          el.attr['dir'] = 'ltr'
        end

        # Do whatever magic kramdown does
        super(el, indent)
      end
    end
  end
end

