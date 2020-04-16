# program to do searches on PubMed

using HTTP

println("this program will search PubMed")

base_query = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi"

query_term = "\"computational biology\" and \"smoking\""

# create the query dictionary to send
# parameters to the REST service
query_dict = Dict()
query_dict["db"] = "pubmed"
query_dict["term"] = query_term
query_dict["retmax"] = 12

# send query to esearch
search_result = String(HTTP.post(base_query, body=HTTP.escapeuri(query_dict)))

print(search_result)

pmid_set = Set()

for result_line in split(search_result, "\n")

    pmid_capture = match(r"<Id>(\d+)<\/Id>", result_line)    

    # only push pmids for lines that contain the match pattern
    if pmid_capture !=  nothing
        push!(pmid_set, pmid_capture[1])
    end

end

println(pmid_set)

# convert the set into a comma-separated list
id_string = join(collect(pmid_set), ",")

println(id_string)

        
base_fetch_query = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi"
query_dict["db"] = "pubmed"
query_dict["id"] = id_string
query_dict["rettype"] = "medline"
query_dict["retmode"] = "text"

fetch_result = String(HTTP.post(base_fetch_query, body=HTTP.escapeuri(query_dict)))

println(fetch_result)














