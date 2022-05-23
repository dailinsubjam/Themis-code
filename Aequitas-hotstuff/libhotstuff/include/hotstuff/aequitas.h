#ifndef _AEQUITAS_H
#define _AEQUITAS_H


#include <vector>
#include <map>
#include <queue>
#include <cstdlib>
#include <iostream>
#include <cstring>
#include "hotstuff/type.h"
#include "hotstuff/entity.h"


namespace  Aequitas {

template <int max_number_cmds>
class TopologyGraph
{
    private:
    //Arrays for adding edges & graph 
    int cnt, top;
    int bel[max_number_cmds], dfn[max_number_cmds], 
        low[max_number_cmds], stck[max_number_cmds];
    bool inst[max_number_cmds];
    std::vector<int> scc_have_after_hami;

    public:
    int num_of_edges;
    int num_solid;
    double avg_circle_size;
    int max_circle_size;
    int min_circle_size;
    

    public:
    std::vector< std::vector<int> > edge; //edge[i][j] = 1 means there is an edge from i to j
    // int edge[max_number_cmds][max_number_cmds];
    bool already_ordered[max_number_cmds];
    int distinct_cmd, distinct_cmd_r;
    int scc;
    std::vector<int> scc_have[max_number_cmds];
    //Arrays for graph after scc
    std::vector<int> edge_with_scc[max_number_cmds];
    int inDegree[max_number_cmds];

    

    private:
    //find strong connected component

    int min(int i, int j)
    {
        if (i < j) return i;
        return j;
    }

    void tarjan(int u)
    {
        dfn[u] = low[u] = ++cnt;
        stck[++top] = u;
        inst[u] = true;
        for (int v = 1; v < max_number_cmds; ++v)
        {
            if(!edge[u][v]) continue;
            if (!dfn[v]){
                tarjan(v);
                low[u] = min(low[u], low[v]);
            } else if (inst[v]) low[u] = min(low[u], dfn[v]);
        }
        if (dfn[u] == low[u])
        {
            ++scc;
            int v;
            do{
                v = stck[top--];
                bel[v] = scc;
                scc_have[scc].push_back(v);
                inst[v] = false;
            } while (v != u);
        }
    }

    void clear_array()
    {
        num_of_edges = 0;
        num_solid = 0;
        distinct_cmd = -1;
        distinct_cmd_r = -2;
        for(int i = 0; i < max_number_cmds; i++)
        {
            scc_have[i].clear();
            edge_with_scc[i].clear();
        }
        // std::memset(edge, 0, sizeof(edge));
        edge.resize(max_number_cmds, std::vector<int>(max_number_cmds));
        cnt = 0, top = 0, scc = 0;
        std::memset(bel, 0, sizeof(bel));
        std::memset(dfn, 0, sizeof(dfn));
        std::memset(low, 0, sizeof(low));
        std::memset(stck, 0, sizeof(stck));
        std::memset(inst, 0, sizeof(inst));
        std::memset(inDegree, 0, sizeof(inDegree));
        avg_circle_size = -1;
        max_circle_size = -1;
        min_circle_size = max_number_cmds;
    }    

    public:

    TopologyGraph() { clear_array(); }
    ~TopologyGraph() {}

    void addedge(int i, int j)
    {
        if(edge[i][j] || edge[j][i]) return;
        if(edge[i][j] == 0) {num_of_edges++; 
                // std::cout << "add from " << i << " to " << j << std::endl;
                // std::cout << "num_of_edges = " << num_of_edges << std::endl;
                }
        edge[i][j] = 1;
    }

    void find_scc()
    {


        for (int i = distinct_cmd; i <= distinct_cmd_r; i++)
            if (!dfn[i])
                tarjan(i);
    }

    void topology_sort()
    {
        for (int i = distinct_cmd; i <= distinct_cmd_r; i++)
        {
            for (int j = distinct_cmd; j <= distinct_cmd_r; j++)
            {
                if(!edge[i][j]) continue;
                int ii = bel[i], jj = bel[j];
                if(ii != jj)
                {
                    edge_with_scc[ii].push_back(jj);
                    ++inDegree[jj];
                }
            }
        }
    }

    bool hami(int cur, int u, int sum_this_scc) {
        // std::cout<<"cur="<<cur<<" u="<<u<<" sum_this_scc="<<sum_this_scc<<std::endl;
        int nxt_hami[max_number_cmds];
        std::memset(nxt_hami, -1, sizeof(nxt_hami));
        int head = cur;
        for(int i = 0; i < sum_this_scc; i++)
        {
            // std::cout<<"i="<<i<<std::endl;
            int new_cur = scc_have[u][i];
            if(new_cur == cur) continue;
            if(edge[new_cur][head]) { // new_cur -> head
                nxt_hami[new_cur] = head;
                head = new_cur;
            } else { // head -> new_cur
                if(!edge[head][new_cur])
                    throw std::runtime_error("Failed to recognize the tournament...");
                int pre = head, pos = nxt_hami[head];
                while(pos != -1 && !edge[new_cur][pos]) {
                    pre = pos;
                    pos = nxt_hami[pre];
                }
                nxt_hami[pre] = new_cur;
                nxt_hami[new_cur] = pos;
            }
        }
        // std::cout<<"Begin to find the circle"<<std::endl;
        // find the circle
        int l = head, r = 0;
        for(int i = l; i > 0; i = nxt_hami[i]) // r is the nearest node to the circle, r->l  is the edge on the circle, r->nxt[r] is the edge on the chain
        {
            // std::cout<<"i="<<i<<std::endl;
            if(r) {
                for(int j = l, k = r; ; k = j, j = nxt_hami[j]) { // k->j is the iteration edge on the circle
                    if(edge[i][j]) {
                        nxt_hami[k] = nxt_hami[r];
                        if(k != r) nxt_hami[r] = l;
                        l = j, r = i;
                        break;
                    }
                    if(j == r) break;
                }
            } else if(edge[i][l]) {
                r = i;
            }
        }
        nxt_hami[r] = l;
        // std::cout<<"Finish finding the circle"<<std::endl;
        for(int i = nxt_hami[l]; i != -1; i = nxt_hami[i]) {
            scc_have_after_hami.push_back(i);
            if(i == l) break;
        }
        return true;
    }
    
    //find hamilton road in the strong connected component G.scc_have[u]
    void find_hamilton(int u)
    {
        if(scc_have[u].size() <= 2) return;
        bool success = 0;
        int sum_this_scc = scc_have[u].size();
        // std::cout << "begin to hami" << std::endl;
        for(int j = 0; j < sum_this_scc; j++)
        {
            // std::cout<<"j="<<j<<std::endl;
            scc_have_after_hami.clear();
            int cur = scc_have[u][j]; 
            if(!hami(cur, u, sum_this_scc) 
             || !edge[scc_have_after_hami[sum_this_scc - 1]][scc_have_after_hami[0]])
            {
                // std::cout<<"A wrong case: ";
                // for(int i = 0; i < sum_this_scc; i++) std::cout<<scc_have_after_hami[i]<<" ";
                // std::cout<<std::endl;
                continue;
            }
            else
            {
                // std::cout<<"successfully find a hamiltonian circle for SCC "<<u<<std::endl;
                success = 1;
                for(int i = 0; i < sum_this_scc; i++)
                    scc_have[u][i] = scc_have_after_hami[i];
                break;
            }
        }
        if(!success)
        {
            throw std::runtime_error("Hamilton Algorithm failed to find a road in SCC...");
        }
    }
     


    bool is_tournament()
    {
        int k = num_solid;// since only the solid tx could be addedge-ed
        // std::cout << "num_solid = " << k << " distinct_cmd = " << distinct_cmd << " distinct_cmd_r = " << distinct_cmd_r << std::endl; 
        if(num_of_edges == k * (k - 1) / 2) return true;
        return false;
    }

    std::vector<uint256_t> finalize(std::vector<uint256_t> &cmd_content)
    {
        //find scc
        find_scc();
        
        //topology sort start...
        topology_sort();

        /*
        printf("scc results begin...\n");
        for(int i = 1; i <= G.scc; i++)
        {
            for(int j = 0; j < G.scc_have[i].size(); j++) printf("%d ", scc_have[i][j]);
            printf("\nedge: ");
            for(int j = 0; j < G.edge_with_scc[i].size(); j++) printf("%d ", edge_with_scc[i][j]);
            printf("\n");
        }
        printf("=====\n");
        */
    
        std::vector<uint256_t> final_ordered_cmds; final_ordered_cmds.clear();
        //now deal with graph after scc
        std::queue<int> que = std::queue<int>();
        int check_whether_all_cmds_are_ordered = 0;
        avg_circle_size = -1;
        max_circle_size = -1;
        min_circle_size = max_number_cmds;
        for (int i = 1; i <= scc; i++)
        {
            // HOTSTUFF_LOG_INFO("the circle size is: %d", scc_have[i].size());
            if (inDegree[i] == 0) que.push(i);
            int cur_scc_size = (int)scc_have[i].size();
            if(avg_circle_size == -1) avg_circle_size = cur_scc_size;
            else avg_circle_size += cur_scc_size;
            if(cur_scc_size > max_circle_size) max_circle_size = cur_scc_size;
            if(cur_scc_size < min_circle_size) min_circle_size = cur_scc_size;
        }
        avg_circle_size = 1.0 * avg_circle_size / scc;
        while(!que.empty())
        {
            std::vector<int> to_be_added; to_be_added.clear();
            while(!que.empty())
            {
                int u = que.front();
                que.pop();
                //Here you need to find a hamilton road
                find_hamilton(u);
                for (int i = 0; i < scc_have[u].size(); i++)
                {
                    already_ordered[scc_have[u][i]] = 1;
                    // HOTSTUFF_LOG_INFO("SCC %d 's nodes: %s", 
                        // u, get_hex10(cmd_content[scc_have[u][i] - 1]).c_str());
                    final_ordered_cmds.push_back(cmd_content[scc_have[u][i] - 1]); 
                    check_whether_all_cmds_are_ordered++;
                }
                for (int i = 0; i < edge_with_scc[u].size(); i++)
                {
                    int v = edge_with_scc[u][i];
                    --inDegree[v];
                    if(inDegree[v] == 0)
                        to_be_added.push_back(v);
                }
                edge_with_scc[u].clear();
            }


            for(int i = 0; i < to_be_added.size(); i++)
                que.push(to_be_added[i]);
        }

        if (check_whether_all_cmds_are_ordered != (distinct_cmd_r - distinct_cmd + 1))
            throw std::runtime_error("Aequitas failed to topology sort the commands...");
        return final_ordered_cmds;
    }
};




}


#endif
