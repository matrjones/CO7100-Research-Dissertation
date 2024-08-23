namespace ReptileAPI.Data
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddInjections(this IServiceCollection services)
        {
            services.AddScoped<IDbInitializer, DbInitializer>();
            return services;
        }
    }
}
