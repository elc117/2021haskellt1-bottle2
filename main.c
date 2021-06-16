#include <HsFFI.h>
#ifdef __GLASGOW_HASKELL__
#include "Main_stub.h"
#endif

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
	int i;
	hs_init(&argc, &argv);

	i = fibonacci_hs(42);
	printf("Fibonacci: %d\n", i);

	char *string = string_test_hs();
	printf("%s\n", string);
	free(string);

	float *floats = float_tuple_list_hs();
	printf("%f %f\n", floats[0], floats[1]);
	free(floats);

	hs_exit();
	return 0;
}
