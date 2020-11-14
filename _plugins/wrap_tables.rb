module Kramdown
  module Converter
    class SheepHtml < Html
      def convert_table(el, indent)
        %Q(<div class="table-wrapper">#{super(el, indent)}</div>)
      end
    end
  end
end
