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
        config = YAML::load(File.open("config/vinculum.yaml"))
        db = Mongo::Connection.new.db(config["Mongo_Database"])
        db[config["Mongo_Document"]].find({"fqdn" => fqdn}, :fields => ["facts"]).each do |node|
            node["facts"].each do |fact, value|
                results << "#{fact} - #{value}"
            end
        end
        return results
    end

    def get_node_list(position)
        config = YAML::load(File.open("config/vinculum.yaml"))
        results = []
        db = Mongo::Connection.new.db(config["Mongo_Database"])
        db[config["Mongo_Document"]].find({}, {:sort => "fqdn", :skip => ((position -1) * 15), :limit => 15}).each do |node|
            results << node
        end
        return results, db["nodes"].find().count
     end
    
    def facts_to_show
       return YAML::load(File.open("#{RAILS_ROOT}/config/vinculum.yaml"))
    end
end
