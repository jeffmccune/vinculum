module PuppetHelper
    require 'mongo'
    require 'pp'
    require 'yaml'

    def get_plugins
        plugins = Dir.glob("vendor/plugins/vinculum_[!action]**")
        results = []
        plugins.each {|plugin| results << plugin.gsub(/.*vinculum_/, "")}
        return results
    end

    def get_actions
        return YAML::load(File.open("config/actions.yaml"))
    end

    def get_facts(fqdn)
        results = []
        db = Mongo::Connection.new.db("puppet")
        db["nodes"].find({"fqdn" => fqdn}, :fields => ["facts"]).each do |node|
            node["facts"].each do |fact, value|
                results << "#{fact} - #{value}"
            end
        end
        return results
    end

    def get_node_list(position)
         results = []
         db = Mongo::Connection.new.db("puppet")
         db["nodes"].find({}, {:sort => "fqdn", :skip => ((position -1) * 15), :limit => 15}).each do |node|
             results << node
         end
         return results, db["nodes"].find().count
     end
end
