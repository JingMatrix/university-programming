/*
 * File: Gaussel.c
 *
 * MATLAB Coder version            : 3.3
 * C/C++ source code generated on  : 27-Sep-2017 12:02:37
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "Gaussel.h"

/* Function Definitions */

/*
 * Arguments    : double A[36]
 *                double b[6]
 *                double tol
 *                double x[6]
 * Return Type  : void
 */
void Gaussel(double A[36], double b[6], double tol, double x[6])
{
  int i;
  int j;
  boolean_T exitg1;
  int k;
  int ixstart;
  double y_data[6];
  double mtmp;
  int ix;
  int i0;
  double a_data[5];
  boolean_T exitg2;
  double b_data[5];
  signed char iv0[2];
  int b_k[2];
  double tmp_data[12];
  int b_i[2];
  double b_b[2];

  /*  Compute the default tolerance if none was provided. */
  /*  Loop over the entire matrix. */
  i = 0;
  j = 0;
  exitg1 = false;
  while ((!exitg1) && ((i + 1 <= 6) && (j + 1 <= 6))) {
    /*  Find value and index of largest element in the remainder of column j. */
    for (k = -1; k + 2 <= 6 - i; k++) {
      y_data[k + 1] = fabs(A[((i + k) + 6 * j) + 1]);
    }

    ixstart = 1;
    mtmp = y_data[0];
    k = 1;
    if ((signed char)(6 - i) > 1) {
      if (rtIsNaN(y_data[0])) {
        ix = 2;
        exitg2 = false;
        while ((!exitg2) && (ix <= (signed char)(6 - i))) {
          ixstart = ix;
          if (!rtIsNaN(y_data[ix - 1])) {
            mtmp = y_data[ix - 1];
            k = ix;
            exitg2 = true;
          } else {
            ix++;
          }
        }
      }

      if (ixstart < (signed char)(6 - i)) {
        while (ixstart + 1 <= (signed char)(6 - i)) {
          if (y_data[ixstart] > mtmp) {
            mtmp = y_data[ixstart];
            k = ixstart + 1;
          }

          ixstart++;
        }
      }
    }

    k += i;

    /*  k referd the index. */
    if (mtmp <= tol) {
      /*  The column is negligible,end the function; */
      exitg1 = true;
    } else {
      /*  Swap i-th and k-th rows. */
      iv0[0] = (signed char)((signed char)(i + 1) - 1);
      iv0[1] = (signed char)((signed char)k - 1);
      b_k[0] = k;
      b_k[1] = i + 1;
      ix = -j;
      for (i0 = 0; i0 <= ix + 5; i0++) {
        for (ixstart = 0; ixstart < 2; ixstart++) {
          tmp_data[ixstart + (i0 << 1)] = A[(b_k[ixstart] + 6 * (j + i0)) - 1];
        }
      }

      ix = 6 - j;
      for (i0 = 0; i0 < ix; i0++) {
        for (ixstart = 0; ixstart < 2; ixstart++) {
          A[iv0[ixstart] + 6 * (j + i0)] = tmp_data[ixstart + (i0 << 1)];
        }
      }

      b_k[0] = k - 1;
      b_k[1] = i;
      b_i[0] = i;
      b_i[1] = k - 1;
      for (i0 = 0; i0 < 2; i0++) {
        b_b[i0] = b[b_k[i0]];
      }

      for (i0 = 0; i0 < 2; i0++) {
        b[b_i[i0]] = b_b[i0];
      }

      /*  Divide the pivot row by the pivot element. */
      b[i] /= A[i + 6 * j];
      mtmp = A[i + 6 * j];
      ix = -j;
      for (i0 = 0; i0 <= ix + 5; i0++) {
        y_data[i0] = A[i + 6 * (j + i0)] / mtmp;
      }

      ix = 6 - j;
      for (i0 = 0; i0 < ix; i0++) {
        A[i + 6 * (j + i0)] = y_data[i0];
      }

      /*  Subtract multiples of the pivot row from all the other rows. */
      for (ixstart = 0; ixstart <= 4 - i; ixstart++) {
        k = (i + ixstart) + 1;
        b[k] -= A[k + 6 * j] * b[i];
        mtmp = A[k + 6 * j];
        ix = -j;
        for (i0 = 0; i0 <= ix + 5; i0++) {
          y_data[i0] = A[k + 6 * (j + i0)] - mtmp * A[i + 6 * (j + i0)];
        }

        ix = 6 - j;
        for (i0 = 0; i0 < ix; i0++) {
          A[k + 6 * (j + i0)] = y_data[i0];
        }
      }

      i++;
      j++;
    }
  }

  for (i = 0; i < 6; i++) {
    x[i] = b[i];
  }

  /*  calculate x. */
  for (i = 0; i < 5; i++) {
    ixstart = i + 1;
    ix = i + 1;
    for (i0 = 0; i0 < ix; i0++) {
      a_data[i0] = A[(6 * ((i0 - i) + 5) - i) + 4];
    }

    ix = i + 1;
    for (i0 = 0; i0 < ix; i0++) {
      b_data[i0] = x[(i0 - i) + 5];
    }

    if (i + 1 == 1) {
      mtmp = 0.0;
      for (i0 = 0; i0 < ixstart; i0++) {
        mtmp += a_data[i0] * b_data[i0];
      }
    } else {
      mtmp = 0.0;
      for (i0 = 0; i0 < ixstart; i0++) {
        mtmp += a_data[i0] * b_data[i0];
      }
    }

    x[4 - i] -= mtmp;
  }
}

/*
 * File trailer for Gaussel.c
 *
 * [EOF]
 */
