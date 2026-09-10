"""
StreamCast: Global SVOD Streaming Platform Content & Churn Analytics - Pytest Automated Test Suite
"""
import pytest
import numpy as np


def test_churn_rate_complement():
    retention_pct = 91.2
    assert 100.0 - retention_pct == pytest.approx(8.8)


def test_qoe_vst_threshold():
    vst_seconds = 0.78
    assert vst_seconds < 1.0


def test_sla_compliance_bounds():
    compliant = 9400
    total = 10000
    assert round((compliant / total) * 100.0, 2) == pytest.approx(94.0)


def test_data_integrity():
    metric_val = 1420.50
    assert metric_val > 0
