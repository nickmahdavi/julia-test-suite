using LinearAlgebra

struct Polynomial{T}
    coefficients::Vector{T}
    
    function Polynomial{T}(coeffs::Vector{T}) where T
        while length(coeffs) > 1 && coeffs[end] ≈ zero(T)
            pop!(coeffs)
        end
        new(coeffs)
    end
end

# Convenience constructor
Polynomial(coeffs::Vector{T}) where T = Polynomial{T}(coeffs)

struct RationalFunction{T}
    numerator::Polynomial{T}
    denominator::Polynomial{T}
    
    function RationalFunction{T}(num::Polynomial{T}, den::Polynomial{T}) where T
        if all(den.coefficients .≈ zero(T))
            throw(DomainError(den, "Denominator cannot be zero polynomial"))
        end
        new(num, den)
    end
end

# Basic operations for Polynomial
function evaluate(p::Polynomial{T}, z::Number) where T
    result = zero(promote_type(T, typeof(z)))
    for (i, coeff) in enumerate(p.coefficients)
        result += coeff * z^(i-1)
    end
    result
end

function (p::Polynomial)(z::Number)
    evaluate(p, z)
end

function evaluate(r::RationalFunction{T}, z::Number) where T
    evaluate(r.numerator, z) / evaluate(r.denominator, z)
end

function (r::RationalFunction)(z::Number)
    evaluate(r, z)
end

struct IterationResult
    escaped::Bool
    iterations::Int
    last_value::Complex
    escape_velocity::Float64
end

function julia_iteration_data(p::Polynomial{T}, 
                            z₀::Complex{Float64};
                            max_iter::Int=100,
                            escape_radius::Float64=2.0) where T
    
    z = z₀
    trajectory = [z]  # Store the orbit for plotting
    
    for i in 1:max_iter
        # Apply the polynomial map
        z = p(z)
        push!(trajectory, z)
        
        # Check if point has escaped
        if abs(z) > escape_radius
            return (escaped=true, 
                    escape_iter=i, 
                    trajectory=trajectory)
        end
    end
    
    # Point didn't escape within max iterations
    return (escaped=false, 
            escape_iter=max_iter, 
            trajectory=trajectory)
end

# Example usage for plotting:
function generate_julia_data(p::Polynomial{T},
                           x_range::LinRange,
                           y_range::LinRange;
                           kwargs...) where T
    
    escape_times = zeros(Int, length(y_range), length(x_range))
    
    for (i, x) in enumerate(x_range)
        for (j, y) in enumerate(y_range)
            z₀ = complex(x, y)
            result = julia_iteration_data(p, z₀; kwargs...)
            escape_times[j, i] = result.escape_iter
        end
    end
    
    return escape_times
end

using CSV, DataFrames


function generate_julia_data_csv(p::Polynomial{T},
                               filename::String;
                               n_points::Int=2000,
                               x_range::Tuple{Float64,Float64}=(-2.0, 2.0),
                               y_range::Tuple{Float64,Float64}=(-2.0, 2.0)) where T
    
    # Create coordinate ranges
    xs = LinRange(x_range[1], x_range[2], n_points)
    ys = LinRange(y_range[1], y_range[2], n_points)
    
    # Preallocate results matrix
    escape_times = zeros(Int, n_points, n_points)
    
    # Calculate escape times
    for (i, x) in enumerate(xs)
        for (j, y) in enumerate(ys)
            z₀ = complex(x, y)
            result = julia_iteration_data(p, z₀)
            escape_times[j, i] = result.escape_iter
        end
        
        # Optional: Print progress every 100 columns
        if i % 100 == 0
            println("Processed column $i of $n_points")
        end
    end
    
    # Convert to DataFrame
    df = DataFrame(escape_times, :auto)
    
    # Add coordinate information
    insertcols!(df, 1, :y => ys)
    
    # Save to CSV
    CSV.write(filename, df)
    
    println("Data saved to $filename")
    return escape_times
end

# Example usage:
# Define polynomial z² + c
c = -0.4 + 0.6im
p = Polynomial([c, 0.0, 1.0])

# Generate and save data
generate_julia_data_csv(p, "julia_set.csv")