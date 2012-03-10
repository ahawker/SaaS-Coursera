#Andrew Hawker
#SaaS - Armando Fox and David Patterson (Spring 2012)
#Assignment 1 - Part 5
#http://spark-university.s3.amazonaws.com/berkeley-saas/homework/hw1.pdf

#5
#Write a 'attr_accessor_with_history' class which provides historial results of previous values.
class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s

    attr_reader attr_name
    attr_reader attr_name + "_history"
    class_eval %Q{
      def #{attr_name}=(value)
        @#{attr_name} = value
        if @#{attr_name}_history.nil?
          @#{attr_name}_history = [nil]
        end
        @#{attr_name}_history.push(value)
      end
    }
  end
end

class Foo
  attr_accessor_with_history :bar
end
