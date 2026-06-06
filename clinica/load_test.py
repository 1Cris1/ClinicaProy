import concurrent.futures
import urllib.request
import time

BASE_URL = 'http://localhost:8080'

endpoints = [
    '/login',
    '/registro',
]

def hit_endpoint(endpoint):
    url = f"{BASE_URL}{endpoint}"
    try:
        start_time = time.time()
        req = urllib.request.Request(url)
        with urllib.request.urlopen(req, timeout=5) as response:
            status_code = response.getcode()
            duration = time.time() - start_time
            return (endpoint, status_code, duration)
    except urllib.error.HTTPError as e:
        return (endpoint, e.code, 0)
    except Exception as e:
        return (endpoint, "ERROR", 0)

def stress_test(num_requests=100, max_workers=20):
    print(f"Iniciando prueba de estres: {num_requests} peticiones concurrentes (max_workers={max_workers})...")
    results = {'/login': {'200': 0, 'other': 0, 'times': []},
               '/registro': {'200': 0, 'other': 0, 'times': []}}

    start_time = time.time()
    
    with concurrent.futures.ThreadPoolExecutor(max_workers=max_workers) as executor:
        # Repartir las peticiones entre los endpoints equitativamente
        tasks = []
        for i in range(num_requests):
            endpoint = endpoints[i % len(endpoints)]
            tasks.append(executor.submit(hit_endpoint, endpoint))
        
        for future in concurrent.futures.as_completed(tasks):
            endpoint, status, duration = future.result()
            if status == 200:
                results[endpoint]['200'] += 1
                results[endpoint]['times'].append(duration)
            else:
                results[endpoint]['other'] += 1

    total_time = time.time() - start_time
    
    print("\n--- RESULTADOS DE LA PRUEBA DE ESTRES ---")
    print(f"Tiempo Total de Prueba: {total_time:.2f} segundos")
    print(f"Peticiones Totales: {num_requests}")
    print(f"Rendimiento Promedio: {num_requests / total_time:.2f} peticiones/segundo\n")
    
    for ep, data in results.items():
        exitos = data['200']
        fallos = data['other']
        if exitos > 0:
            avg_time = sum(data['times']) / exitos
            max_time = max(data['times'])
        else:
            avg_time = 0
            max_time = 0
        print(f"Endpoint: {ep}")
        print(f"  Exitos (HTTP 200): {exitos}")
        print(f"  Fallos/Errores: {fallos}")
        print(f"  Tiempo Respuesta Promedio: {avg_time*1000:.2f} ms")
        print(f"  Tiempo Maximo: {max_time*1000:.2f} ms")
        print("-" * 40)

if __name__ == '__main__':
    # Hacemos 200 peticiones en ráfagas de 50
    stress_test(num_requests=200, max_workers=50)
