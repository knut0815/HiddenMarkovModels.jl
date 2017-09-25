######################################################################################
### So far the generic filter here is common to all algorithms working "in a basis".
### This includes discrete filters, kernel-kernel filters, and kernel-density filters.
### With some more work it can probably be made to work for particle filtering and Kalman filtering.
######################################################################################



# Initial nonlinear filter is typically given as a sample, must be expressed in basis
function filtr(model,ini_sample,data,filtering_method)
    ini = initial_filter(model,ini_sample,filtering_method)
    _filtr(model,ini,data,filtering_method)
end



function _filtr(model,ini_filter,data,filtering_method)
    T=length(data)
    nx = length(ini_filter)

    fil=Array{Float64}(nx,T)
    fil[:,1]=ini_filter

    pred = zeros(nx) 

    print("Running the generic filter... ")
    for t=1:T-1
        # print((t%10==0)?"$t ":"")
        
        filter_update!(view(fil,:,t+1),pred,model,view(fil,:,t),data[t],data[t+1],filtering_method)
        
    end
    println()

    fil
end
