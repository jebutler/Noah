require 'base64'
module Noah
  class Ephemeral < Model #NYI

    attribute :path
    attribute :data
    attribute :lifetime

    index :path

    def validate
      super
      assert_present :path
      assert_unique :path
    end

    def name
      @name = path
    end

    def to_hash
      data.nil? ? d=nil : d=Base64.decode64(data)
      h = {:path => path, :data => d, :created_at => created_at, :updated_at => :updated_at}
      super.merge(h)
    end
    protected
    def save_hook
      # called after any create,update,delete
      # logic needed to expire any orphaned ephemerals
    end

    private
    def path_protected?(path_part)
      # Check for protected paths in ephemeral nodes
    end
      
  end

end